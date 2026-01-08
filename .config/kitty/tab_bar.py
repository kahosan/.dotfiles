"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import datetime
import re
import subprocess
import time

from kitty.boss import get_boss  # 导入 boss 以便控制重绘
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_powerline,
    draw_title,
)
from kitty.utils import color_as_int

opts = get_options()

ICON: str = "  "
ICON_LENGTH: int = len(ICON)
ICON_FG: int = as_rgb(color_as_int(opts.color1))
ICON_BG: int = as_rgb(color_as_int(opts.color8))
ICON_BG: int = 0

# CLOCK_FG = as_rgb(0xFFE2E2)
CLOCK_FG = as_rgb(0xFFEFFFF)
CLOCK_BG = as_rgb(0xF38BA8)
DATE_FG = as_rgb(0xFFFFFF)
DATE_BG = as_rgb(0x585B70)

# SSH Status
SSH_FG = as_rgb(0xFFEFFFF)
SSH_BG = as_rgb(0x212121)

# --- 1. 定时器相关全局变量 ---
REFRESH_TIME = 5  # 每 5 秒重绘一次 tab bar
_timer_id = None

# --- 2. SSH 缓存相关变量 ---
_ssh_cache = ""
_ssh_last_check = 0
SSH_CHECK_INTERVAL = 5  # 每 5 秒检查一次 SSH


def _redraw_tab_bar(timer_id):
    """定时器回调函数：强制重绘 tab bar"""
    boss = get_boss()
    # 遍历所有 OS 窗口并标记 tab bar 为 dirty，迫使 kitty 重绘
    for window in boss.os_window_map.values():
        window.mark_tab_bar_dirty()


def _draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return screen.cursor.x

    fg, bg, bold, italic = (
        screen.cursor.fg,
        screen.cursor.bg,
        screen.cursor.bold,
        screen.cursor.italic,
    )
    screen.cursor.bold, screen.cursor.italic, screen.cursor.fg, screen.cursor.bg = (
        True,
        False,
        ICON_FG,
        ICON_BG,
    )
    screen.draw(ICON)
    screen.cursor.x = ICON_LENGTH
    screen.cursor.fg, screen.cursor.bg, screen.cursor.bold, screen.cursor.italic = (
        fg,
        bg,
        bold,
        italic,
    )
    return screen.cursor.x


def _draw_ssh_status():
    global _ssh_cache, _ssh_last_check
    now = time.time()

    # 如果距离上次检查还不到间隔时间，直接返回缓存结果
    if now - _ssh_last_check < SSH_CHECK_INTERVAL:
        return _ssh_cache

    try:
        result = subprocess.run(["ps", "-o", "tty,command"], capture_output=True, text=True, check=True)

        lines = result.stdout.strip().split("\n")
        ssh_sessions = []

        for line in lines:
            if "kitten ssh" in line and "KITTY_WINDOW_ID" not in line:
                parts = line.strip().split(None, 2)
                if len(parts) >= 3:
                    tty = parts[0]
                    ssh_target = parts[2].replace("ssh ", "")
                    tty_match = re.search(r"ttys(\d+)", tty)
                    if tty_match:
                        tty_num = int(tty_match.group(1)) + 1
                        ssh_sessions.append(f"{tty_num}:{ssh_target}")

        _ssh_cache = "|".join(ssh_sessions)
        _ssh_last_check = now
        return _ssh_cache

    except Exception:
        return ""


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
    use_kitty_render_function: bool = False,
) -> int:
    if use_kitty_render_function:
        end = draw_tab_with_powerline(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)
        return end

    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)

    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.cursor.x = max(screen.cursor.x, ICON_LENGTH)
        screen.draw("…")
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)

    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    screen.cursor.bg = 0
    return screen.cursor.x


def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return screen.cursor.x

    # 这里的 datetime.now() 只有在重绘时才会更新
    cells = [
        (CLOCK_FG, CLOCK_BG, datetime.datetime.now().strftime(" %H:%M:%S ")),
        (DATE_FG, DATE_BG, datetime.datetime.now().strftime(" %Y/%m/%d ")),
    ]

    ssh_status = _draw_ssh_status()
    if ssh_status:
        cells.insert(
            0,
            (SSH_FG, SSH_BG, f" SSH({ssh_status}) "),
        )

    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


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
    # _draw_icon(screen, index)
    # Set cursor to where `left_status` ends, instead `right_status`,
    # to enable `open new tab` feature

    global _timer_id
    if _timer_id is None:
        # add_timer(callback, interval_seconds, repeat=True)
        _timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)

    end = _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
        use_kitty_render_function=False,
    )
    _draw_right_status(
        screen,
        is_last,
    )
    return end
