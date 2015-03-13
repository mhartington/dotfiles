# -*- coding: utf-8 -*-
#
# Copyright (c) 2009 by xt <xt@bash.no>
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
# (this script requires WeeChat 0.3.0 or newer)
#
# History:
# 2009-12-15, xt
#  version 0.3: moved around some control structures to not be as noisy
# 2009-12-02, xt
#  version 0.2: bugfix, more printing
# 2009-12-01, xt <xt@bash.no>
#  version 0.1: initial release

import weechat as w
import time

SCRIPT_NAME    = "buffer_autoclose"
SCRIPT_AUTHOR  = "xt <xt@bash.no>"
SCRIPT_VERSION = "0.3"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "Automatically close inactive private message buffers"

settings = {
        'interval': '1', # How often in minutes to check
        'age_limit': '30', # How old in minutes before auto close
        'ignore': '', # Buffers to ignore (use full name: server.buffer_name)
}

if w.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE,
                    SCRIPT_DESC, "", ""):
    for option, default_value in settings.iteritems():
        if not w.config_is_set_plugin(option):
            w.config_set_plugin(option, default_value)
    w.hook_timer(\
            int(w.config_get_plugin('interval')) * 1000 * 60,
            0,
            0,
            "close_time_cb",
            '')


def get_all_buffers():
    '''Returns list with pointers of all open buffers.'''
    buffers = []
    infolist = w.infolist_get('buffer', '', '')
    while w.infolist_next(infolist):
        buffer_type = w.buffer_get_string(w.infolist_pointer(infolist, 'pointer'), 'localvar_type')
        if buffer_type == 'private': # we only close private message buffers for now
            buffers.append(w.infolist_pointer(infolist, 'pointer'))
    w.infolist_free(infolist)
    return buffers

def get_last_line_date(buffer):
    date = '1970-01-01 01:00:00'
    infolist = w.infolist_get('buffer_lines', buffer, '')
    while w.infolist_prev(infolist):
        date = w.infolist_time(infolist, 'date')
        if date != '1970-01-01 01:00:00':
        # Some lines like "Day changed to" message doesn't have date 
        # set so loop until we find a message that does
            break
    w.infolist_free(infolist)
    return date

def is_in_hotlist(buffer):
    ''' Returns true if buffer is in hotlist, false if not'''

    hotlist = w.infolist_get('hotlist', '', '')
    found = False
    while w.infolist_next(hotlist):
        thebuffer = w.infolist_pointer(hotlist, 'buffer_pointer')
        if thebuffer == buffer:
            found = True
            name = w.buffer_get_string(thebuffer, 'short_name')
            break

    w.infolist_free(hotlist)
    return found

def close_time_cb(buffer, args):
    ''' Callback for check for inactivity and close '''

    for buffer in get_all_buffers():
        name = w.buffer_get_string(buffer, 'name')


        date = get_last_line_date(buffer)
        date = time.mktime(time.strptime(date, '%Y-%m-%d %H:%M:%S'))
        now = time.time()
        seconds_old = now - date
        if seconds_old > int(w.config_get_plugin('age_limit'))*60:
            if is_in_hotlist(buffer):
                #w.prnt('', '%s: Not closing buffer: %s: it is in hotlist' %(SCRIPT_NAME, name))
                continue
            if name in w.config_get_plugin('ignore').split(','):
                #w.prnt('', '%s: Not closing buffer: %s: it is in ignore list' %(SCRIPT_NAME, name))
                continue
            if buffer == w.current_buffer():
                # Never close current buffer
                #w.prnt('', '%s: Not closing buffer: %s: it is in currently active' %(SCRIPT_NAME, name))
                continue
            if len(w.buffer_get_string(buffer, 'input')):
                # Don't close buffers with text on input line
                #w.prnt('', '%s: Not closing buffer: %s: it has input' %(SCRIPT_NAME, name))
                continue
                
            w.prnt('', '%s: Closing buffer: %s' %(SCRIPT_NAME, name))
            w.command(buffer, '/buffer close')
        #else:
        #    w.prnt('', '%s: Not closing buffer: %s: it is too new: %s' %(SCRIPT_NAME, name, seconds_old))

    return w.WEECHAT_RC_OK
