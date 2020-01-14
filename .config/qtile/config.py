# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer


#### Some special functions ####

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


# From https://gitlab.com/dwt1/dotfiles/blob/master/.config/qtile/config.py
def window_to_previous_group():
    @lazy.function
    def __inner(qtile):
        previous_group_name = qtile.current_group.get_previous_group().name
        qtile.current_window.togroup(previous_group_name, switch_group=True)
    return __inner

def window_to_next_group():
    @lazy.function
    def __inner(qtile):
        next_group_name = qtile.current_group.get_next_group().name
        qtile.current_window.togroup(next_group_name, switch_group=True)
    return __inner


@lazy.function
def show_shortcuts(qtile):
    qtile.widgets_map['info'].update('Hallo?')
    key_map = {"mod1": "alt", "mod4": "super"}
    shortcuts_path = "{0}/{1}".format(os.environ["HOME"], "qtile_shortcuts")
    shortcuts = open("{0}".format(shortcuts_path), "w")
    shortcuts.write("{0:30}| {1:50}\n".format("KEYS COMBINATION", "COMMAND"))
    shortcuts.write("{0:80}\n".format("=" * 80))
    for key in keys:
        key_comb = ""
        for modifier in key.modifiers:
            key_comb += key_map.get(modifier, modifier) + "+"
        key_comb += key.key
        shortcuts.write("{0:30}| ".format(key_comb))
        cmd_str = ""
        for command in key.commands:
            cmd_str += command.name + " "
            for arg in command.args:
                cmd_str += "{0} ".format(repr(arg))
        shortcuts.write("{0:50}\n".format(cmd_str))
        shortcuts.write("{0:80}\n".format("-" * 80))
    shortcuts.close()
    lazy.spawn("xterm -wf -e less {0}".format(shortcuts_path))


#### Key bindings ####

def init_keys():
    keys = [
        # Switch between windows in current stack pane
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        # Move windows in current stack
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        # Switch through the different layouts
        Key([mod, "control"], "j", lazy.next_layout()),
        Key([mod, "control"], "k", lazy.prev_layout()),

        # Maximize / minimize current window
        Key([mod], "m", lazy.window.toggle_maximize()),
        # Normalize all windows by restoring the default size ratios
        Key([mod], "n", lazy.layout.normalize()),
        # Toggle floating
        Key([mod, "shift"], "t", lazy.window.toggle_floating()),
        Key([mod, "shift"], "s", show_shortcuts),

        # Move current window between different groups
        Key([mod, "shift"], "h", window_to_previous_group()),
        Key([mod, "shift"], "l", window_to_next_group()),
        # Grow size of current window (XmonadTall)
        Key([mod, "control"], "h", lazy.layout.shrink(),
            lazy.layout.decrease_nmaster()),
        # Shrink size of current window (XmonadTall)
        Key([mod, "control"], "l", lazy.layout.grow(),
            lazy.layout.increase_nmaster()),

        # Start the configured terminal
        Key([mod], "Return", lazy.spawn(myterm)),
        # Kill active window
        Key([mod], "w", lazy.window.kill()),
        # Restart qtile / reload configuration
        Key([mod, "control"], "r", lazy.restart()),
        # Quit qtile
        Key([mod, "control"], "q", lazy.shutdown()),
        # Run a command; will open an input-field
        Key([mod], "r", lazy.spawncmd()),
    ]
    return keys


def init_mouse():
    # Drag floating layouts.
    return [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]

def init_group_names():
    return [(i, {'layout': 'monadtall'}) for i in "asdfuiop"]


def init_groups():
    groups = [Group(name, **kwargs) for name, kwargs in group_names]

    for i in groups:
        # mod1 + letter of group = switch to group
        keys.append(
            Key([mod], i.name, lazy.group[i.name].toscreen())
        )

        # mod1 + shift + letter of group = switch to & move focused window to group
        keys.append(
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
        )
    groups.append(ScratchPad("scratchpad", [DropDown("term", "uxterm", opacity=0.8),
        DropDown("qshell", "qshell", x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
            on_focus_lost_hide=True)]))
    keys.append(Key(['shift'], 'F11', lazy.group['scratchpad'].dropdown_toggle('term')))
    keys.append(Key(['shift'], 'F12', lazy.group['scratchpad'].dropdown_toggle('qshell')))
    return groups


##### BAR COLORS #####

def init_colors():
#     return [["#282828", "#282828"], # panel background
#             ["#3c3836", "#3c3836"], # background for current screen tab
#             ["#ebdbb2", "#ebdbb2"], # font color for group names
#             ["#ff5555", "#ff5555"], # background color for layout widget
#             ["#000000", "#000000"], # background for other screen tabs
#             ["#A77AC4", "#A77AC4"], # dark green gradiant for other screen tabs
#             ["#50fa7b", "#50fa7b"], # background color for network widget
#             ["#7197E7", "#7197E7"], # background color for pacman widget
#             ["#9AEDFE", "#9AEDFE"], # background color for cmus widget
#             ["#000000", "#000000"], # background color for clock widget
#             ["#434758", "#434758"]] # background color for systray widget
    # gruvbox dark theme colors
    # Some colors are repeated with different names, using the dark mode pic from
    # https://github.com/morhetz/gruvbox
    return {
        'bg'             : '#282828',
        'neutral_red'    : '#cc241d',
        'neutral_green'  : '#98971a',
        'neutral_yellow' : '#d79921',
        'neutral_blue'   : '#458588',
        'neutral_purple' : '#b16286',
        'neutral_aqua'   : '#689d6a',
        'neutral_gray'   : '#a89984',

        'light_red'      : '#cc241d',
        'light_green'    : '#98971a',
        'light_yellow'   : '#d79921',
        'light_blue'     : '#458588',
        'light_purple'   : '#b16286',
        'light_aqua'     : '#689d6a',
        'light_orange'   : '#fe8019',
        'fg'             : '#ebdbb2',

        'dark0_hard'     : '#1d2021',
        'dark0'          : '#282828',
        'dark0_soft'     : '#32302f',
        'dark1'          : '#3c3836',
        'dark2'          : '#504945',
        'dark3'          : '#665c54',
        'dark4'          : '#7c6f64',
        'dark_gray'      : '#928374',
        'dark_orange'    : '#d65d0e',

        'bg0_h'          : '#1d2021',
        'bg0'            : '#282828',
        'bg0_s'          : '#32302f',
        'bg1'            : '#3c3836',
        'bg2'            : '#504945',
        'bg3'            : '#665c54',
        'bg4'            : '#7c6f64',

        'fg4'            : '#a89984',
        'fg3'            : '#bdae93',
        'fg2'            : '#d5c4a1',
        'fg1'            : '#ebdbb2',
        'fg0'            : '#fbf1c7',

        # Plus some more
        'white'          : '#ffffff',
    }


#### LAYOUTS ####

def init_floating_layout():
    return layout.Floating(border_focus=colors['light_blue'])


def init_layout_theme():
    return {
        "border_width": 2,
        "margin": 4,
        "border_focus": colors['light_blue'],
        "border_normal": colors['bg0_h']
    }


def init_border_args():
    return {"border_width": 2}


def init_layouts():
    return [#layout.MonadWide(**layout_theme),
        #layout.Bsp(**layout_theme),
        #layout.Stack(stacks=2, **layout_theme),
        #layout.Columns(**layout_theme),
        #layout.RatioTile(**layout_theme),
        #layout.VerticalTile(**layout_theme),
        #layout.Tile(shift_windows=True, **layout_theme),
        #layout.Matrix(**layout_theme),
        #layout.Zoomy(**layout_theme),
        layout.MonadTall(**layout_theme),
        layout.Max(**layout_theme),
#         layout.TreeTab(
#             font = "Fira Mono Medium",
#             fontsize = 9,
#             sections = ["FIRST", "SECOND"],
#             section_fontsize = 10,
#             bg_color = colors["bg0_s"],
#             active_bg = colors['neutral_blue'],
#             active_fg = colors['fg'],
#             inactive_bg = colors['neutral_gray'],
#             inactive_fg = colors['fg3'],
#             padding_y = 5,
#             section_top = 10,
#             panel_width = 150,
#             **layout_theme
#             ),
        layout.Floating(**layout_theme)]


#### WIDGETS ####

def init_widgets_defaults():
    return dict(font="Fira Mono Medium",
                fontsize=10,
                padding=2,
                background=colors['bg0_s'])


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors['fg'],
            background = colors['bg0_s']
        ),
        widget.GroupBox(font="Fira Mono Medium",
            fontsize = 10,
            borderwidth = 2,
            active = colors['white'],
            inactive = colors['fg3'],
            rounded = True,
            highlight_method = "border",
            this_current_screen_border = colors['light_blue'],
            this_screen_border = colors ['light_blue'],
            other_current_screen_border = colors['neutral_blue'],
            other_screen_border = colors['light_aqua'],
            foreground = colors['fg'],
            background = colors['bg']
        ),
        widget.Sep(
            linewidth = 0,
            padding = 10,
            foreground = colors['fg'],
            background = colors['bg0']
        ),
        widget.Prompt(
            prompt=prompt,
            font="Fira Mono Medium",
            padding=10,
            foreground = colors['fg'],
            background = colors['bg3']
        ),
        widget.Sep(
            linewidth = 0,
            padding = 10,
            foreground = colors['fg'],
            background = colors['bg0_s']
        ),
        widget.WindowName(),
        widget.Systray(),
        widget.TextBox(text='', name='info',
                       foreground = colors['fg'],
                       background = colors['bg']
        ),
        Spacer(length=10),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        widget.Wallpaper(directory='~/.config/wallpapers',
            wallpaper='space.jpg',
            label='',
            one_screen=True),
        widget.CurrentLayoutIcon(
            foreground = colors['fg'],
            background = colors['bg0_s']
        ),
    ]
    return widgets_list


#### SCREENS ####

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=0.75, size=20))]


if __name__ in ["config", "__main__"]:
    mod = "mod1"                   # Set mod-key to ALT
    #myterm = "uxterm"
    myterm = "terminator"

    colors = init_colors()
    keys = init_keys()
    mouse = init_mouse()
    group_names = init_group_names()
    groups = init_groups()
    floating_layout = init_floating_layout()
    layout_theme = init_layout_theme()
    border_args = init_border_args()
    layouts = init_layouts()
    screens = init_screens()
    widget_defaults = init_widgets_defaults()
    widgets_list = init_widgets_list()

    dgroups_key_binder = None
    dgroups_app_rules = []
    main = None
    follow_mouse_focus = True
    bring_front_click = False
    cursor_warp = False
    floating_layout = layout.Floating()
    auto_fullscreen = True
    focus_on_window_activation = "smart"
    extentions = []


# Some Java-apps need this
#wmname = "LG3D"
wmname = "qtile"
