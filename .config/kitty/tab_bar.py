"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import ctypes
import ctypes.util
import datetime
import sys
import time
from pathlib import Path

from kittens.ssh.utils import get_connection_data
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_title,
)
from kitty.utils import color_as_int
from kitty.window import Window

# 获取 Kitty 配置
opts = get_options()

# 全局定时器 ID
REFRESH_TIMER_ID: int | None = None

RightCell = tuple[int, int, str]
NetSample = tuple[float, int, int]
NET_SAMPLE: NetSample | None = None
NET_STATUS: str | None = None

AF_LINK = 18
IFF_LOOPBACK = 0x8
IFF_UP = 0x1
UINT32_MAX = 2**32


class _Sockaddr(ctypes.Structure):
    _fields_ = [
        ("sa_len", ctypes.c_uint8),
        ("sa_family", ctypes.c_uint8),
        ("sa_data", ctypes.c_char * 14),
    ]


class _IfAddrs(ctypes.Structure):
    pass


_IfAddrsPtr = ctypes.POINTER(_IfAddrs)
_IfAddrs._fields_ = [
    ("ifa_next", _IfAddrsPtr),
    ("ifa_name", ctypes.c_char_p),
    ("ifa_flags", ctypes.c_uint),
    ("ifa_addr", ctypes.POINTER(_Sockaddr)),
    ("ifa_netmask", ctypes.POINTER(_Sockaddr)),
    ("ifa_dstaddr", ctypes.POINTER(_Sockaddr)),
    ("ifa_data", ctypes.c_void_p),
]


class _IfData(ctypes.Structure):
    _pack_ = 4
    _fields_ = [
        ("ifi_type", ctypes.c_uint8),
        ("ifi_typelen", ctypes.c_uint8),
        ("ifi_physical", ctypes.c_uint8),
        ("ifi_addrlen", ctypes.c_uint8),
        ("ifi_hdrlen", ctypes.c_uint8),
        ("ifi_recvquota", ctypes.c_uint8),
        ("ifi_xmitquota", ctypes.c_uint8),
        ("ifi_unused1", ctypes.c_uint8),
        ("ifi_mtu", ctypes.c_uint32),
        ("ifi_metric", ctypes.c_uint32),
        ("ifi_baudrate", ctypes.c_uint32),
        ("ifi_ipackets", ctypes.c_uint32),
        ("ifi_ierrors", ctypes.c_uint32),
        ("ifi_opackets", ctypes.c_uint32),
        ("ifi_oerrors", ctypes.c_uint32),
        ("ifi_collisions", ctypes.c_uint32),
        ("ifi_ibytes", ctypes.c_uint32),
        ("ifi_obytes", ctypes.c_uint32),
    ]


_MACOS_GETIFADDRS = None
_MACOS_FREEIFADDRS = None
_MACOS_GETIFADDRS_LOADED = False


class ColorPalette:
    """颜色配置"""

    try:
        COLOR0 = as_rgb(color_as_int(opts.color0))
        COLOR1 = as_rgb(color_as_int(opts.color1))
        COLOR2 = as_rgb(color_as_int(opts.color2))
        COLOR3 = as_rgb(color_as_int(opts.color3))
        COLOR4 = as_rgb(color_as_int(opts.color4))
        COLOR5 = as_rgb(color_as_int(opts.color5))
        COLOR6 = as_rgb(color_as_int(opts.color6))
        COLOR7 = as_rgb(color_as_int(opts.color7))
        COLOR8 = as_rgb(color_as_int(opts.color8))
        COLOR9 = as_rgb(color_as_int(opts.color9))
        COLOR10 = as_rgb(color_as_int(opts.color10))
        COLOR11 = as_rgb(color_as_int(opts.color11))
        COLOR12 = as_rgb(color_as_int(opts.color12))
        COLOR13 = as_rgb(color_as_int(opts.color13))
        COLOR14 = as_rgb(color_as_int(opts.color14))
        COLOR15 = as_rgb(color_as_int(opts.color15))
    except (AttributeError, ValueError):
        pass

    # 自定义颜色
    CLOCK_FG = as_rgb(0xF38BA8)
    DATE_FG = as_rgb(0xB4BEFE)

    SSH_FG = as_rgb(0xFFFFFF)
    SSH_BG = as_rgb(0x9ACBD0)

    FG = as_rgb(0xBBBBBB)

    RESET = 0


class Config:
    """通用配置"""

    ICON: str = "  "
    ICON_FG: int = ColorPalette.COLOR1
    ICON_BG: int = ColorPalette.RESET

    # 时钟显示取整间隔 (秒)
    CLOCK_ROUND_INTERVAL: int = 5
    # 自动刷新频率 (秒) - 设为 1 秒以保证视觉上的及时响应
    REFRESH_TIME: float = 1.0
    # 网络采样频率 (秒)，略小于刷新频率，避免定时器轻微抖动导致隔轮更新
    NET_SAMPLE_INTERVAL: float = 0.8


def _redraw_tab_bar(timer_id: int | None) -> None:
    """定时器回调：强制刷新 Tab 栏"""
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


def _ensure_refresh_timer() -> None:
    """初始化自动刷新定时器"""
    global REFRESH_TIMER_ID

    if REFRESH_TIMER_ID is None:
        REFRESH_TIMER_ID = add_timer(_redraw_tab_bar, Config.REFRESH_TIME, True)


def _get_now_rounded() -> datetime.datetime:
    """获取当前时间并向下取整到最近的 5 秒"""
    now = datetime.datetime.now()
    ts = now.timestamp()
    rounded_ts = (ts // Config.CLOCK_ROUND_INTERVAL) * Config.CLOCK_ROUND_INTERVAL
    return datetime.datetime.fromtimestamp(rounded_ts)


def _draw_icon(screen: Screen, index: int) -> int:
    """绘制 Tab 图标"""
    if index != 1:
        return 0

    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = Config.ICON_FG
    screen.cursor.bg = Config.ICON_BG
    screen.draw(Config.ICON)

    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(Config.ICON)
    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    right_status_length: int,  # 新增参数：右侧长度
) -> int:
    """绘制左侧 Tab 标题"""

    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)

    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces

    # 计算剩余空间时，考虑右侧状态栏的长度
    # 确保左侧标题不会覆盖到右侧的时钟
    available_space = screen.columns - right_status_length - before

    # 如果当前光标位置超过了可用空间，需要回退并画省略号
    if screen.cursor.x > before + available_space:
        screen.cursor.x = before + available_space - 1  # 留一个位置给省略号
        screen.draw("…")

    # 原有的额外截断逻辑（处理 trailing spaces 等）
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.cursor.x = max(screen.cursor.x, len(Config.ICON) if index == 1 else 0)
        screen.draw("…")

    if trailing_spaces:
        screen.draw(" " * trailing_spaces)

    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = ColorPalette.RESET

    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)

    screen.cursor.bg = ColorPalette.RESET
    return screen.cursor.x


def _draw_right_status(screen: Screen, is_last: bool, cells: list[RightCell]) -> int:
    """绘制右侧状态栏"""
    if not is_last:
        return screen.cursor.x

    # 计算总长度
    right_status_length = _cells_length(cells)

    # 填充中间空白
    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.cursor.bg = ColorPalette.RESET
        screen.draw(" " * draw_spaces)

    # 绘制组件
    for fg, bg, content in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(content)

    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


def _cells_length(cells: list[RightCell]) -> int:
    """计算状态栏组件占用的字符长度"""
    return sum(len(content) for _, _, content in cells)


def _read_linux_net_bytes() -> tuple[int, int] | None:
    """读取 Linux 非 loopback 网卡累计收发字节数"""
    rx_total = 0
    tx_total = 0

    try:
        with Path("/proc/net/dev").open(mode="r", encoding="utf-8") as net_dev:
            lines = net_dev.readlines()[2:]
    except OSError:
        return None

    for line in lines:
        iface, sep, data = line.partition(":")
        if not sep or iface.strip() == "lo":
            continue

        fields = data.split()
        if len(fields) < 16:
            continue

        try:
            rx_total += int(fields[0])
            tx_total += int(fields[8])
        except ValueError:
            continue

    return rx_total, tx_total


def _load_macos_getifaddrs() -> bool:
    """加载 macOS getifaddrs/freeifaddrs 函数"""
    global _MACOS_FREEIFADDRS, _MACOS_GETIFADDRS, _MACOS_GETIFADDRS_LOADED

    if _MACOS_GETIFADDRS_LOADED:
        return _MACOS_GETIFADDRS is not None and _MACOS_FREEIFADDRS is not None

    _MACOS_GETIFADDRS_LOADED = True
    libsystem_path = ctypes.util.find_library("System") or "/usr/lib/libSystem.B.dylib"

    try:
        libsystem = ctypes.CDLL(libsystem_path)
    except OSError:
        return False

    getifaddrs = libsystem.getifaddrs
    getifaddrs.argtypes = [ctypes.POINTER(_IfAddrsPtr)]
    getifaddrs.restype = ctypes.c_int

    freeifaddrs = libsystem.freeifaddrs
    freeifaddrs.argtypes = [_IfAddrsPtr]
    freeifaddrs.restype = None

    _MACOS_GETIFADDRS = getifaddrs
    _MACOS_FREEIFADDRS = freeifaddrs
    return True


def _read_macos_net_bytes() -> tuple[int, int] | None:
    """读取 macOS 非 loopback 网卡累计收发字节数"""
    if not _load_macos_getifaddrs():
        return None

    addrs = _IfAddrsPtr()
    if _MACOS_GETIFADDRS(ctypes.byref(addrs)) != 0:
        return None

    rx_total = 0
    tx_total = 0

    try:
        current = addrs
        while current:
            item = current.contents
            current = item.ifa_next

            if not item.ifa_name or not item.ifa_addr or not item.ifa_data:
                continue

            name = item.ifa_name.decode("utf-8", "ignore")
            if name.startswith("lo") or item.ifa_flags & IFF_LOOPBACK:
                continue
            if not item.ifa_flags & IFF_UP:
                continue
            if item.ifa_addr.contents.sa_family != AF_LINK:
                continue

            data = ctypes.cast(item.ifa_data, ctypes.POINTER(_IfData)).contents
            rx_total += int(data.ifi_ibytes)
            tx_total += int(data.ifi_obytes)
    finally:
        _MACOS_FREEIFADDRS(addrs)

    return rx_total, tx_total


def _read_net_bytes() -> tuple[int, int] | None:
    """读取本机累计收发字节数"""
    if sys.platform == "darwin":
        return _read_macos_net_bytes()
    if sys.platform.startswith("linux"):
        return _read_linux_net_bytes()
    return None


def _format_net_rate(bytes_per_second: float) -> str:
    """格式化网络速率"""
    rate = max(0.0, bytes_per_second)
    for unit in ("B", "K", "M", "G"):
        if rate < 1024.0 or unit == "G":
            if unit == "B":
                return f"{rate:.0f}{unit}"
            return f"{rate:.1f}{unit}"
        rate /= 1024.0
    return "0B"


def _byte_delta(current: int, previous: int) -> int:
    """计算累计字节差，兼容 macOS 32-bit counter 回绕"""
    if current >= previous:
        return current - previous
    if sys.platform == "darwin":
        return current + UINT32_MAX - previous
    return 0


def _get_net_status() -> str | None:
    """获取缓存后的本机上下行速率"""
    global NET_SAMPLE, NET_STATUS

    now = time.monotonic()
    if NET_SAMPLE is not None:
        last_time = NET_SAMPLE[0]
        if now - last_time < Config.NET_SAMPLE_INTERVAL:
            return NET_STATUS

    current = _read_net_bytes()
    if current is None:
        return None

    rx_bytes, tx_bytes = current

    if NET_SAMPLE is None:
        NET_SAMPLE = (now, rx_bytes, tx_bytes)
        NET_STATUS = "d: 0B u: 0B"
        return NET_STATUS

    last_time, last_rx_bytes, last_tx_bytes = NET_SAMPLE
    elapsed = now - last_time

    rx_rate = _byte_delta(rx_bytes, last_rx_bytes) / elapsed
    tx_rate = _byte_delta(tx_bytes, last_tx_bytes) / elapsed

    NET_SAMPLE = (now, rx_bytes, tx_bytes)
    NET_STATUS = f"d: {_format_net_rate(rx_rate)} u: {_format_net_rate(tx_rate)}"
    return NET_STATUS


def _get_active_window() -> Window | None:
    """获取当前活动窗口"""
    tm = get_boss().active_tab_manager
    if tm is None:
        return None
    return tm.active_window


def _get_active_layout_name() -> str:
    """获取当前活动 Tab 的布局名"""
    tm = get_boss().active_tab_manager
    if tm is None or tm.active_tab is None:
        return ""
    return tm.active_tab.current_layout.name or ""


def _get_ssh_status(active_window: Window | None) -> str | None:
    if active_window is None:
        return None

    ssh_cmdline = active_window.ssh_kitten_cmdline()

    try:
        if ssh_cmdline:
            ssh_cmdline = [item for item in ssh_cmdline if item != "-tt"]
            conn_data = get_connection_data(ssh_cmdline)
            if conn_data:
                conn_data_hostname = conn_data.hostname
                user_and_host = conn_data_hostname.split("@")
                if len(user_and_host) == 1:
                    return user_and_host[0]
                elif len(user_and_host) == 2:
                    return f"{user_and_host[0]}:{user_and_host[1]}"
    except Exception:
        return "error"
    return None


def _build_right_cells() -> list[RightCell]:
    """构造右侧全局状态栏组件"""
    now = _get_now_rounded()
    cells = []

    active_layout_name = _get_active_layout_name()
    if active_layout_name == "stack":
        cells.append(
            (ColorPalette.FG, ColorPalette.RESET, f"z: {active_layout_name}|"),
        )

    ssh_status = _get_ssh_status(_get_active_window())
    if ssh_status:
        cells.append(
            (ColorPalette.FG, ColorPalette.RESET, f"ssh: {ssh_status.lower()}|"),
        )

    net_status = _get_net_status()
    if net_status:
        cells.append((ColorPalette.FG, ColorPalette.RESET, f"{net_status}|"))

    cells.extend(
        [
            (ColorPalette.DATE_FG, ColorPalette.RESET, now.strftime("%Y/%m/%d ")),
            (ColorPalette.CLOCK_FG, ColorPalette.RESET, now.strftime("%H:%M:%S ")),
        ]
    )

    return cells


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # 1. 初始化定时器 (只运行一次)
    _ensure_refresh_timer()

    # 2. 预先准备右侧状态栏数据
    #    这样做是为了提前计算长度，传递给左侧绘制函数，防止重叠
    right_cells = _build_right_cells()

    # 计算右侧总长度 (如果在第一个Tab就计算出来，后续Tab都知道右边被占用了多少)
    right_status_len = _cells_length(right_cells)

    # 4. 绘制左侧 (传入右侧长度以限制标题宽度)
    end = _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        right_status_len,
    )

    # 5. 绘制右侧
    _draw_right_status(screen, is_last, right_cells)

    return end
