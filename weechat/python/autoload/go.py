# -*- coding: utf-8 -*-
#
# Copyright (C) 2009-2014 Sébastien Helleu <flashcode@flashtux.org>
# Copyright (C) 2010 m4v <lambdae2@gmail.com>
# Copyright (C) 2011 stfn <stfnmd@googlemail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#
# History:
#
# 2014-05-12, Sébastien Helleu <flashcode@flashtux.org>:
#     version 2.0: add help on options, replace option "sort_by_activity" by
#                  "sort" (add sort by name and first match at beginning of
#                  name and by number), PEP8 compliance
# 2012-11-26, Nei <anti.teamidiot.de>
#     version 1.9: add auto_jump option to automatically go to buffer when it
#                  is uniquely selected
# 2012-09-17, Sébastien Helleu <flashcode@flashtux.org>:
#     version 1.8: fix jump to non-active merged buffers (jump with buffer name
#                  instead of number)
# 2012-01-03 nils_2 <weechatter@arcor.de>
#     version 1.7: add option use_core_instead_weechat
# 2012-01-03, Sébastien Helleu <flashcode@flashtux.org>:
#     version 1.6: make script compatible with Python 3.x
# 2011-08-24, stfn <stfnmd@googlemail.com>:
#     version 1.5: /go with name argument jumps directly to buffer
#                  Remember cursor position in buffer input
# 2011-05-31, Elián Hanisch <lambdae2@gmail.com>:
#     version 1.4: Sort list of buffers by activity.
# 2011-04-25, Sébastien Helleu <flashcode@flashtux.org>:
#     version 1.3: add info "go_running" (used by script input_lock.rb)
# 2010-11-01, Sébastien Helleu <flashcode@flashtux.org>:
#     version 1.2: use high priority for hooks to prevent conflict with other
#                  plugins/scripts (WeeChat >= 0.3.4 only)
# 2010-03-25, Elián Hanisch <lambdae2@gmail.com>:
#     version 1.1: use a space for match the end of a string
# 2009-11-16, Sébastien Helleu <flashcode@flashtux.org>:
#     version 1.0: add new option for displaying short names
# 2009-06-15, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.9: fix typo in /help go with command /key
# 2009-05-16, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.8: search buffer by number, fix bug when window is split
# 2009-05-03, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.7: eat tab key (do not complete input, just move buffer
#                  pointer)
# 2009-05-02, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.6: sync with last API changes
# 2009-03-22, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.5: update modifier signal name for input text display,
#                  fix arguments for function string_remove_color
# 2009-02-18, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.4: do not hook command and init options if register failed
# 2009-02-08, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.3: case insensitive search for buffers names
# 2009-02-08, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.2: add help about Tab key
# 2009-02-08, Sébastien Helleu <flashcode@flashtux.org>:
#     version 0.1: initial release
#

"""
Quick jump to buffers.
(this script requires WeeChat 0.3.0 or newer)
"""

from __future__ import print_function

SCRIPT_NAME = 'go'
SCRIPT_AUTHOR = 'Sébastien Helleu <flashcode@flashtux.org>'
SCRIPT_VERSION = '2.0'
SCRIPT_LICENSE = 'GPL3'
SCRIPT_DESC = 'Quick jump to buffers'

SCRIPT_COMMAND = 'go'

IMPORT_OK = True

try:
    import weechat
except ImportError:
    print('This script must be run under WeeChat.')
    print('Get WeeChat now at: http://www.weechat.org/')
    IMPORT_OK = False

import re

# script options
SETTINGS = {
    'color_number': (
        'yellow,magenta',
        'color for buffer number (not selected)'),
    'color_number_selected': (
        'yellow,red',
        'color for selected buffer number'),
    'color_name': (
        'black,cyan',
        'color for buffer name (not selected)'),
    'color_name_selected': (
        'black,brown',
        'color for a selected buffer name'),
    'color_name_highlight': (
        'red,cyan',
        'color for highlight in buffer name (not selected)'),
    'color_name_highlight_selected': (
        'red,brown',
        'color for highlight in a selected buffer name'),
    'message': (
        'Go to: ',
        'message to display before list of buffers'),
    'short_name': (
        'off',
        'display and search in short names instead of buffer name'),
    'sort': (
        'number,beginning',
        'comma-separated list of keys to sort buffers '
        '(the order is important, sorts are performed in the given order): '
        'name = sort by name (or short name), ',
        'hotlist = sort by hotlist order, '
        'number = first match a buffer number before digits in name, '
        'beginning = first match at beginning of names (or short names); '
        'the default sort of buffers is by numbers'),
    'use_core_instead_weechat': (
        'off',
        'use name "core" instead of "weechat" for core buffer'),
    'auto_jump': (
        'off',
        'automatically jump to buffer when it is uniquely selected'),
}

# hooks management
HOOK_COMMAND_RUN = {
    'input': ('/input *', 'go_command_run_input'),
    'buffer': ('/buffer *', 'go_command_run_buffer'),
    'window': ('/window *', 'go_command_run_window'),
}
hooks = {}

# input before command /go (we'll restore it later)
saved_input = ''
saved_input_pos = 0

# last user input (if changed, we'll update list of matching buffers)
old_input = None

# matching buffers
buffers = []
buffers_pos = 0


def go_option_enabled(option):
    """Checks if a boolean script option is enabled or not."""
    return weechat.config_string_to_boolean(weechat.config_get_plugin(option))


def go_info_running(data, info_name, arguments):
    """Returns "1" if go is running, otherwise "0"."""
    return '1' if 'modifier' in hooks else '0'


def go_unhook_one(hook):
    """Unhook something hooked by this script."""
    global hooks
    if hook in hooks:
        weechat.unhook(hooks[hook])
        del hooks[hook]


def go_unhook_all():
    """Unhook all."""
    go_unhook_one('modifier')
    for hook in HOOK_COMMAND_RUN:
        go_unhook_one(hook)


def go_hook_all():
    """Hook command_run and modifier."""
    global hooks
    priority = ''
    version = weechat.info_get('version_number', '') or 0
    # use high priority for hook to prevent conflict with other plugins/scripts
    # (WeeChat >= 0.3.4 only)
    if int(version) >= 0x00030400:
        priority = '2000|'
    for hook, value in HOOK_COMMAND_RUN.items():
        if hook not in hooks:
            hooks[hook] = weechat.hook_command_run(
                '%s%s' % (priority, value[0]),
                value[1], '')
    if 'modifier' not in hooks:
        hooks['modifier'] = weechat.hook_modifier(
            'input_text_display_with_cursor', 'go_input_modifier', '')


def go_start(buf):
    """Start go on buffer."""
    global saved_input, saved_input_pos, old_input, buffers_pos
    go_hook_all()
    saved_input = weechat.buffer_get_string(buf, 'input')
    saved_input_pos = weechat.buffer_get_integer(buf, 'input_pos')
    weechat.buffer_set(buf, 'input', '')
    old_input = None
    buffers_pos = 0


def go_end(buf):
    """End go on buffer."""
    global saved_input, saved_input_pos, old_input
    go_unhook_all()
    weechat.buffer_set(buf, 'input', saved_input)
    weechat.buffer_set(buf, 'input_pos', str(saved_input_pos))
    old_input = None


def go_match_beginning(buf, string):
    """Check if a string matches the beginning of buffer name/short name."""
    if not string:
        return False
    esc_str = re.escape(string)
    if re.search(r'^#?' + esc_str, buf['name']) \
            or re.search(r'^#?' + esc_str, buf['short_name']):
        return True
    return False


def go_now(buf, args):
    """Go to buffer specified by args."""
    listbuf = go_matching_buffers(args)
    if not listbuf:
        return

    # prefer buffer that matches at beginning (if option is enabled)
    if 'beginning' in weechat.config_get_plugin('sort').split(','):
        for index in range(len(listbuf)):
            if go_match_beginning(listbuf[index], args):
                weechat.command(buf,
                                '/buffer ' + str(listbuf[index]['full_name']))
                return

    # jump to first buffer in matching buffers by default
    weechat.command(buf, '/buffer ' + str(listbuf[0]['full_name']))


def go_cmd(data, buf, args):
    """Command "/go": just hook what we need."""
    global hooks
    if args:
        go_now(buf, args)
    elif 'modifier' in hooks:
        go_end(buf)
    else:
        go_start(buf)
    return weechat.WEECHAT_RC_OK


def go_matching_buffers(strinput):
    """Return a list with buffers matching user input."""
    global buffers_pos
    listbuf = []
    if len(strinput) == 0:
        buffers_pos = 0
    strinput = strinput.lower()
    infolist = weechat.infolist_get('buffer', '', '')
    while weechat.infolist_next(infolist):
        short_name = weechat.infolist_string(infolist, 'short_name')
        if go_option_enabled('short_name'):
            name = weechat.infolist_string(infolist, 'short_name')
        else:
            name = weechat.infolist_string(infolist, 'name')
        if name == 'weechat' and go_option_enabled('use_core_instead_weechat'):
            name = 'core'
        number = weechat.infolist_integer(infolist, 'number')
        full_name = weechat.infolist_string(infolist, 'full_name')
        if not full_name:
            full_name = '%s.%s' % (
                weechat.infolist_string(infolist, 'plugin_name'),
                weechat.infolist_string(infolist, 'name'))
        pointer = weechat.infolist_pointer(infolist, 'pointer')
        matching = name.lower().find(strinput) >= 0
        if not matching and strinput[-1] == ' ':
            matching = name.lower().endswith(strinput.strip())
        if not matching and strinput.isdigit():
            matching = str(number).startswith(strinput)
        if len(strinput) == 0 or matching:
            listbuf.append({
                'number': number,
                'short_name': short_name,
                'name': name,
                'full_name': full_name,
                'pointer': pointer,
            })
    weechat.infolist_free(infolist)

    # sort buffers
    hotlist = []
    infolist = weechat.infolist_get('hotlist', '', '')
    while weechat.infolist_next(infolist):
        hotlist.append(
            weechat.infolist_pointer(infolist, 'buffer_pointer'))
    weechat.infolist_free(infolist)
    last_index_hotlist = len(hotlist)

    def _sort_name(buf):
        """Sort buffers by name (or short name)."""
        return buf['name']

    def _sort_hotlist(buf):
        """Sort buffers by hotlist order."""
        try:
            return hotlist.index(buf['pointer'])
        except ValueError:
            # not in hotlist, always last.
            return last_index_hotlist

    def _sort_match_number(buf):
        """Sort buffers by match on number."""
        return 0 if str(buf['number']) == strinput else 1

    def _sort_match_beginning(buf):
        """Sort buffers by match at beginning."""
        return 0 if go_match_beginning(buf, strinput) else 1

    funcs = {
        'name': _sort_name,
        'hotlist': _sort_hotlist,
        'number': _sort_match_number,
        'beginning': _sort_match_beginning,
    }

    for key in weechat.config_get_plugin('sort').split(','):
        if key in funcs:
            listbuf = sorted(listbuf, key=funcs[key])

    if not strinput:
        index = [i for i, buf in enumerate(listbuf)
                 if buf['pointer'] == weechat.current_buffer()]
        if index:
            buffers_pos = index[0]

    return listbuf


def go_buffers_to_string(listbuf, pos, strinput):
    """Return string built with list of buffers found (matching user input)."""
    string = ''
    strinput = strinput.lower()
    for i in range(len(listbuf)):
        selected = '_selected' if i == pos else ''
        index = listbuf[i]['name'].lower().find(strinput)
        if index >= 0:
            index2 = index + len(strinput)
            name = '%s%s%s%s%s' % (
                listbuf[i]['name'][:index],
                weechat.color(weechat.config_get_plugin(
                    'color_name_highlight' + selected)),
                listbuf[i]['name'][index:index2],
                weechat.color(weechat.config_get_plugin(
                    'color_name' + selected)),
                listbuf[i]['name'][index2:])
        else:
            name = listbuf[i]['name']
        string += ' %s%s%s%s%s' % (
            weechat.color(weechat.config_get_plugin(
                'color_number' + selected)),
            str(listbuf[i]['number']),
            weechat.color(weechat.config_get_plugin(
                'color_name' + selected)),
            name,
            weechat.color('reset'))
    return '  ' + string if string else ''


def go_input_modifier(data, modifier, modifier_data, string):
    """This modifier is called when input text item is built by WeeChat.

    This is commonly called after changes in input or cursor move: it builds
    a new input with prefix ("Go to:"), and suffix (list of buffers found).
    """
    global old_input, buffers, buffers_pos
    if modifier_data != weechat.current_buffer():
        return ''
    names = ''
    new_input = weechat.string_remove_color(string, '')
    new_input = new_input.lstrip()
    if old_input is None or new_input != old_input:
        old_buffers = buffers
        buffers = go_matching_buffers(new_input)
        if buffers != old_buffers and len(new_input) > 0:
            if len(buffers) == 1 and go_option_enabled('auto_jump'):
                weechat.command(modifier_data, '/wait 1ms /input return')
            buffers_pos = 0
        old_input = new_input
    names = go_buffers_to_string(buffers, buffers_pos, new_input.strip())
    return weechat.config_get_plugin('message') + string + names


def go_command_run_input(data, buf, command):
    """Function called when a command "/input xxx" is run."""
    global buffers, buffers_pos
    if command == '/input search_text' or command.find('/input jump') == 0:
        # search text or jump to another buffer is forbidden now
        return weechat.WEECHAT_RC_OK_EAT
    elif command == '/input complete_next':
        # choose next buffer in list
        buffers_pos += 1
        if buffers_pos >= len(buffers):
            buffers_pos = 0
        weechat.hook_signal_send('input_text_changed',
                                 weechat.WEECHAT_HOOK_SIGNAL_STRING, '')
        return weechat.WEECHAT_RC_OK_EAT
    elif command == '/input complete_previous':
        # choose previous buffer in list
        buffers_pos -= 1
        if buffers_pos < 0:
            buffers_pos = len(buffers) - 1
        weechat.hook_signal_send('input_text_changed',
                                 weechat.WEECHAT_HOOK_SIGNAL_STRING, '')
        return weechat.WEECHAT_RC_OK_EAT
    elif command == '/input return':
        # switch to selected buffer (if any)
        go_end(buf)
        if len(buffers) > 0:
            weechat.command(
                buf, '/buffer ' + str(buffers[buffers_pos]['full_name']))
        return weechat.WEECHAT_RC_OK_EAT
    return weechat.WEECHAT_RC_OK


def go_command_run_buffer(data, buf, command):
    """Function called when a command "/buffer xxx" is run."""
    return weechat.WEECHAT_RC_OK_EAT


def go_command_run_window(data, buf, command):
    """Function called when a command "/window xxx" is run."""
    return weechat.WEECHAT_RC_OK_EAT


def go_unload_script():
    """Function called when script is unloaded."""
    go_unhook_all()
    return weechat.WEECHAT_RC_OK


def go_main():
    """Entry point."""
    if not weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                            SCRIPT_LICENSE, SCRIPT_DESC,
                            'go_unload_script', ''):
        return
    weechat.hook_command(
        SCRIPT_COMMAND,
        'Quick jump to buffers', '[name]',
        'name: directly jump to buffer by name (without argument, list is '
        'displayed)\n\n'
        'You can bind command to a key, for example:\n'
        '  /key bind meta-g /go\n\n'
        'You can use completion key (commonly Tab and shift-Tab) to select '
        'next/previous buffer in list.',
        '%(buffers_names)',
        'go_cmd', '')

    # set default settings
    version = weechat.info_get('version_number', '') or 0
    for option, value in SETTINGS.items():
        if not weechat.config_is_set_plugin(option):
            weechat.config_set_plugin(option, value[0])
        if int(version) >= 0x00030500:
            weechat.config_set_desc_plugin(
                option, '%s (default: "%s")' % (value[1], value[0]))
    weechat.hook_info('go_running',
                      'Return "1" if go is running, otherwise "0"',
                      '',
                      'go_info_running', '')


if __name__ == "__main__" and IMPORT_OK:
    go_main()
