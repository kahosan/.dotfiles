"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import datetime

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
REFRESH_TIMER_ID = None


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
    CLOCK_FG = as_rgb(0xFFEFFFF)
    CLOCK_BG = as_rgb(0xF38BA8)
    DATE_FG = as_rgb(0xFFFFFF)
    DATE_BG = as_rgb(0x585B70)

    SSH_FG = as_rgb(0xFFFFFF)
    SSH_BG = as_rgb(0x9ACBD0)

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


def _redraw_tab_bar(timer_id):
    """定时器回调：强制刷新 Tab 栏"""
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


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


def _draw_right_status(
    screen: Screen, is_last: bool, cells: list[tuple[int, int, str]]
) -> int:
    """绘制右侧状态栏"""
    if not is_last:
        return screen.cursor.x

    # 计算总长度
    right_status_length = sum(len(content) for _, _, content in cells)

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


def _get_ssh_status(active_window: Window) -> str | None:
    ssh_cmdline = []
    ssh_cmdline = active_window.ssh_kitten_cmdline()

    try:
        if ssh_cmdline != []:
            ssh_cmdline = filter(lambda item: item != "-tt", ssh_cmdline)
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
    global REFRESH_TIMER_ID

    # 1. 初始化定时器 (只运行一次)
    if REFRESH_TIMER_ID is None:
        REFRESH_TIMER_ID = add_timer(_redraw_tab_bar, Config.REFRESH_TIME, True)

    # 2. 预先准备右侧状态栏数据
    #    这样做是为了提前计算长度，传递给左侧绘制函数，防止重叠
    now = _get_now_rounded()
    right_cells = [
        (ColorPalette.CLOCK_FG, ColorPalette.CLOCK_BG, now.strftime(" %H:%M:%S ")),
        (ColorPalette.DATE_FG, ColorPalette.DATE_BG, now.strftime(" %Y/%m/%d ")),
    ]

    ssh_status = _get_ssh_status(get_boss().active_tab_manager.active_window)
    if ssh_status:
        ssh_status = ssh_status.lower()
        right_cells.insert(
            0,
            (ColorPalette.SSH_FG, ColorPalette.SSH_BG, f" ssh: {ssh_status} "),
        )

    # 计算右侧总长度 (如果在第一个Tab就计算出来，后续Tab都知道右边被占用了多少)
    right_status_len = sum(len(c[2]) for c in right_cells)

    # 3. 绘制图标
    # _draw_icon(screen, index)

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
