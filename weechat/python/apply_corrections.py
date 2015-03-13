# -*- coding: utf-8 -*-
#
# Copyright (C) 2012 Chris Johnson <raugturi@gmail.com>
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

# apply_corrections
#
# A weechat plugin to re-print a user's messages with corrections applied when
# they send a correction string (ex: s/typo/replacement).
#
# The following options are availalble:
#
# check_every: Interval, in seconds, between each check for expired messages.
#              If set to 0 no check will be performed and all messages will be
#              saved indefinitely.
#
# data_timeout: Time, in seconds, before a message is expired. If set to 0
#               messages will never expire.
#
# message_limit: Number of messages to store per nick. If set to 0 all messages
#                will be saved until they expire.
#
# print_format: Format string for the printed corrections.
#               Default: "[nick]: [corrected]"
#
#               Variables allowed:
#
#               [nick]:        The nick of the person who sent the messages.
#               [corrected]:   The corrected text of the previous message(s).
#               [correction]:  The correction (format: s/typo/replacement).
#               [original]:    The original message before correction.
#               [pattern]:     The "typo" portion of the correction.
#               [replacement]: The "replacement" portion of the correction.
#               [timestamp]:   The timestamp of the original message.
#
# print_limit: Maximum number of lines to correct and print to the buffer. If
#              set to 0 all lines that match the pattern will be printed.
#
# Note: Setting check_every, data_timeout, message_limit, or some combination
# thereof to 0's will eat a lot of memory very quickly as it will drastically
# increase the size of the dictionary holding previous messages.  Likewise,
# setting print_limit to 0 with a large number of saved messages will quickly
# fill your screen with a bunch of stuff should someone submit a generic
# enough correction string.

# History:
#
# 2014-05-10, Sébastien Helleu <flashcode@flashtux.org>
#     version 1.2: change hook_print callback argument type of
#                  displayed/highlight (WeeChat >= 1.0)
# 2012-10-09, Chris Johnson <raugturi@gmail.com>:
#     version 1.1: change some more variable names for clarity/consistency
# 2012-10-08, Chris Johnson <raugturi@gmail.com>:
#     version 1.0: fix get_corrected_messages so that the most recent messages
#                  are corrected and returned
# 2012-10-08, Chris Johnson <raugturi@gmail.com>:
#     version 0.9: use defaultdict to handle missing keys, flatten dict by
#                  using (buffer, nick) tuple as key, simplify message logging
#                  logic, rename some stuff for clarity.
# 2012-10-08, Chris Johnson <raugturi@gmail.com>:
#     version 0.8: remove empty buffers and nicks during clean-up
# 2012-09-05, Chris Johnson <raugturi@gmail.com>:
#     version 0.7: fix bug when restoring defaults for options that require
#                  integer values
# 2012-09-05, Chris Johnson <raugturi@gmail.com>:
#     version 0.6: copy info from README into script and shorten the variable
#                  descriptions
# 2012-09-01, Chris Johnson <raugturi@gmail.com>:
#     version 0.5: don't log the reprinted messages
# 2012-08-31, Chris Johnson <raugturi@gmail.com>:
#     version 0.4: use same timestamp as buffer when reprinting, instead
#                  of epoch
# 2012-08-31, Chris Johnson <raugturi@gmail.com>:
#     version 0.3: switch to [var] style variables for print format
# 2012-08-30, Chris Johnson <raugturi@gmail.com>:
#     version 0.2: fixed search for typos so if regex fails it falls back
#                  to string.find
# 2012-08-30, Chris Johnson <raugturi@gmail.com>:
#     version 0.1: initial release

import_ok = True

try:
    import weechat
except ImportError:
    print('This script must be run under WeeChat.')
    print('Get WeeChat now at: http://www.weechat.org/')
    import_ok = False

try:
    import re
    import time
    from operator import itemgetter
    from collections import defaultdict
except ImportError as message:
    print('Missing package(s) for %s: %s' % (SCRIPT_NAME, message))
    import_ok = False

SCRIPT_NAME = 'apply_corrections'
SCRIPT_AUTHOR = 'Chris Johnson <raugturi@gmail.com>'
SCRIPT_VERSION = '1.2'
SCRIPT_LICENSE = 'GPL3'
SCRIPT_DESC = "When a correction (ex: s/typo/replacement) is sent, print the "\
              "user's previous message(s) with the corrected text instead."

# Default settings for the plugin.
settings = {'check_every': '5',
            'data_timeout': '60',
            'message_limit': '2',
            'print_format': '[nick]: [corrected]',
            'print_limit': '1'}

# Initialize the dictionary to store most recent messages per buffer per nick.
LASTWORDS = defaultdict(list)


def apply_correction(message, pattern, replacement):
    """
    Replaces all occurences of pattern in message with replacment.  It tries to
    treat the pattern and replacement as regular expressions, but falls back to
    string replace if that fails.
    """

    try:
        message = re.compile(pattern).sub(replacement, message)
    except:
        message = message.replace(pattern, replacement)

    return message


def get_corrected_messages(nick, log, correction):
    """
    Return list of messages that match the pattern, with corrections applied.
    Limited to print_limit items, sorted by timestamp ascending.
    """

    print_limit = get_option_int('print_limit')
    corrected_messages = []
    pattern, replacement = correction.split('/')[1:3]

    for message in log:
        if print_limit and len(corrected_messages) >= print_limit:
            break
        original = message.get('message', '')
        if original:
            try:
                match = re.match(re.compile('.*%s.*' % pattern), original)
            except:
                match = original.find(pattern) != -1
            finally:
                if match:
                    corrected = apply_correction(original,
                                                 pattern,
                                                 replacement)
                    timeformat = weechat.config_string(
                        weechat.config_get('weechat.look.buffer_time_format'))
                    timestamp = time.strftime(
                        timeformat,
                        time.localtime(float(message['timestamp'])))
                    corrected_messages.append({'nick': nick,
                                               'corrected': corrected,
                                               'correction': correction,
                                               'original': original,
                                               'pattern': pattern,
                                               'replacement': replacement,
                                               'timestamp': timestamp})

    return sorted(corrected_messages, key=itemgetter('timestamp'))


def get_option_int(option):
    """
    Checks to see if a configuration option is an integer and sets it back to
    the default if it isn't.  Returns the value when done.
    """

    try:
        value = int(weechat.config_get_plugin(option))
    except ValueError:
        weechat.config_set_plugin(option, settings[option])
        value = int(weechat.config_get_plugin(option))

    return value


def get_valid_messages(log, expiry):
    """
    Return only the messages that haven't expired.
    """

    valid = []
    for message in log:
        try:
            timestamp = int(message.get('timestamp', 0))
            if timestamp > expiry:
                valid.append(message)
        except ValueError:
            continue

    return valid


def clear_messages_cb(data, remaining_calls):
    """
    Callback that clears old messages from the LASTWORDS dictionary.  The time
    limit is the number of seconds specified in plugin's data_timeout setting.
    If data_timeout is set to 0 then no messages are cleared.
    """

    data_timeout = get_option_int('data_timeout')
    if data_timeout:
        expiry = time.time() - data_timeout
        for buff, nick in LASTWORDS.keys():
            valid_messages = get_valid_messages(LASTWORDS[(buff,nick)], expiry)
            if valid_messages:
                LASTWORDS[(buff, nick)] = valid_messages
            else:
                del LASTWORDS[(buff,nick)]

    return weechat.WEECHAT_RC_OK


def handle_message_cb(data, buffer, date, tags, disp, hl, nick, message):
    """
    Callback that handles new messages.  If the message is in the format of a
    regex find/replace (ex. 's/typo/replacement/', 'nick: s/typo/replacement')
    then the last print_limit messages for that nick are re-printed to the
    current buffer in their oringal order with the change applied.  Otherwise
    the message is stored in LASTWORDS dictionary for this buffer > nick.
    """

    # Don't do anything if the message isn't suppose to be displayed.
    if int(disp):
        buffer_name = weechat.buffer_get_string(buffer, 'name')
        log = LASTWORDS[(buffer_name, nick)]

        # Matches on both 's/typo/replacement' and 'nick: s/typo/replacement',
        # mainly because of bitlbee since it puts your nick in front of
        # incoming messages.
        #
        # Nick regex nicked from colorize_nicks available here:
        # http://www.weechat.org/scripts/source/stable/colorize_nicks.py.html/
        valid_nick = r'([@~&!%+])?([-a-zA-Z0-9\[\]\\`_^\{|\}]+)'
        valid_correction = r's/[^/]*/[^/]*'
        correction_message_pattern = re.compile(
                r'(%s:\s*)?(%s)(/)?$' % (valid_nick, valid_correction))
        match = re.match(correction_message_pattern, message)

        if match:
            # If message is a correction and we have previous messages from
            # this nick, print up to print_limit of the nick's previous
            # messages with corrections applied, in their original order.
            correction = match.group(4)
            if log and correction:
                print_format = weechat.config_get_plugin('print_format')
                for cm in get_corrected_messages(nick, log, correction):
                    corrected_msg = print_format
                    for k, v in cm.iteritems():
                        corrected_msg = corrected_msg.replace('[%s]' % k, v)
                    weechat.prnt_date_tags(buffer, 0, 'no_log', corrected_msg)
        else:
            # If it's not a correction, store the message in LASTWORDS.
            log.insert(0, {'message': message, 'timestamp': date})
            # If there's a per-nick limit, shorten the list to match.
            message_limit = get_option_int('message_limit')
            while message_limit and len(log) > message_limit:
                log.pop()

    return weechat.WEECHAT_RC_OK


def load_config(data=None, option=None, value=None):
    """
    Load configuration options and (re)register hook_timer to clear old
    messages based on the current value of check_every.  If check_every is 0
    then messages are never cleared.
    """

    # On initial load set any unset options to the defaults.
    if not option:
        for option, default in settings.iteritems():
            if not weechat.config_is_set_plugin(option):
                weechat.config_set_plugin(option, default)

    if not option or option.endswith('check_every'):
        # If hook_timer for clearing old messages is set already, clear it.
        old_hook = globals().get('CLEAR_HOOK', None)
        if old_hook is not None:
            weechat.unhook(old_hook)

        # Register hook_timer to clear old messages.
        check_every = get_option_int('check_every') * 1000
        if check_every:
            globals()['CLEAR_HOOK'] = weechat.hook_timer(
                    check_every, 0, 0, 'clear_messages_cb', '')

    return weechat.WEECHAT_RC_OK


def desc_options():
    """
    Load descriptions for all the options.
    """

    weechat.config_set_desc_plugin(
            'check_every', 'Interval between each check for expired messages.')

    weechat.config_set_desc_plugin(
            'data_timeout', 'Time before a message is expired.')

    weechat.config_set_desc_plugin(
            'message_limit', 'Number of messages to store per nick.')

    weechat.config_set_desc_plugin(
            'print_format', 'Format string for the printed corrections.')

    weechat.config_set_desc_plugin(
            'print_limit', 'Maximum number of lines to correct.')

    return weechat.WEECHAT_RC_OK


if __name__ == '__main__' and import_ok:
    if weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                        SCRIPT_LICENSE, SCRIPT_DESC, '', ''):
        # Load the configuration options.
        load_config()

        # Set up the descriptions for each option.
        desc_options()

        # Register hook to run load_config when options are changed.
        weechat.hook_config('plugins.var.python.%s.*' % SCRIPT_NAME,
                            'load_config', '')

        # Register hook_print to process each new message as it comes in.
        weechat.hook_print('', '', '', 1, 'handle_message_cb', '')
