#
# Copyright (C) 2008-2014 Sebastien Helleu <flashcode@flashtux.org>
# Copyright (C) 2011-2013 Nils G <weechatter@arcor.de>
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
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#
# Display sidebar with list of buffers.
#
# History:
#
# 2014-08-29, Patrick Steinhardt <ps@pks.im>:
#     v4.9: add support for specifying custom buffer names
# 2014-07-19, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.8: add support of ctrl + mouse wheel to jump to previous/next buffer,
#           new option "mouse_wheel"
# 2014-06-22, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.7: fix typos in options
# 2014-04-05, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.6: add support of hidden buffers (WeeChat >= 0.4.4)
# 2014-01-01, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.5: add option "mouse_move_buffer"
# 2013-12-11, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.4: fix buffer number on drag to the end of list when option
#           weechat.look.buffer_auto_renumber is off
# 2013-12-10, nils_2@freenode.#weechat:
#     v4.3: add options "prefix_bufname" and "suffix_bufname (idea by silverd)
#         : fix hook_timer() for show_lag wasn't disabled
#         : improved signal handling (less updating of buffers list)
# 2013-11-07, Sebastien Helleu <flashcode@flashtux.org>:
#     v4.2: use default filling "columns_vertical" when bar position is top/bottom
# 2013-10-31, nils_2@freenode.#weechat:
#     v4.1: add option "detach_buffer_immediately" (idea by farn)
# 2013-10-20, nils_2@freenode.#weechat:
#     v4.0: add options "detach_displayed_buffers", "detach_display_window_number"
# 2013-09-27, nils_2@freenode.#weechat:
#     v3.9: add option "toggle_bar" and option "show_prefix_query" (idea by IvarB)
#         : fix problem with linefeed at end of list of buffers (reported by grawity)
# 2012-10-18, nils_2@freenode.#weechat:
#     v3.8: add option "mark_inactive", to mark buffers you are not in (idea by xrdodrx)
#         : add wildcard "*" for immune_detach_buffers (idea by StarWeaver)
#         : add new options "detach_query" and "detach_free_content" (idea by StarWeaver)
# 2012-10-06, Nei <anti.teamidiot.de>:
#     v3.7: call menu on right mouse if menu script is loaded.
# 2012-10-06, nils_2 <weechatter@arcor.de>:
#     v3.6: add new option "hotlist_counter" (idea by torque).
# 2012-06-02, nils_2 <weechatter@arcor.de>:
#     v3.5: add values "server|channel|private|all|keepserver|none" to option "hide_merged_buffers" (suggested by dominikh).
# 2012-05-25, nils_2 <weechatter@arcor.de>:
#     v3.4: add new option "show_lag".
# 2012-04-07, Sebastien Helleu <flashcode@flashtux.org>:
#     v3.3: fix truncation of wide chars in buffer name (option name_size_max) (bug #36034)
# 2012-03-15, nils_2 <weechatter@arcor.de>:
#     v3.2: add new option "detach"(weechat >= 0.3.8)
#           add new option "immune_detach_buffers" (requested by Mkaysi)
#           add new function buffers_whitelist add|del|reset (suggested by FiXato)
#           add new function buffers_detach add|del|reset
# 2012-03-09, Sebastien Helleu <flashcode@flashtux.org>:
#     v3.1: fix reload of config file
# 2012-01-29, nils_2 <weechatter@arcor.de>:
#     v3.0: fix: buffers did not update directly during window_switch (reported by FiXato)
# 2012-01-29, nils_2 <weechatter@arcor.de>:
#     v2.9: add options "name_size_max" and "name_crop_suffix"
# 2012-01-08, nils_2 <weechatter@arcor.de>:
#     v2.8: fix indenting for option "show_number off"
#           fix unset of buffer activity in hotlist when buffer was moved with mouse
#           add buffer with free content and core buffer sorted first (suggested  by nyuszika7h)
#           add options queries_default_fg/bg and queries_message_fg/bg (suggested by FiXato)
#           add clicking with left button on current buffer will do a jump_previously_visited_buffer (suggested by FiXato)
#           add clicking with right button on current buffer will do a jump_next_visited_buffer
#           add additional informations in help texts
#           add default_fg and default_bg for whitelist channels
#           internal changes  (script is now 3Kb smaller)
# 2012-01-04, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.7: fix regex lookup in whitelist buffers list
# 2011-12-04, nils_2 <weechatter@arcor.de>:
#     v2.6: add own config file (buffers.conf)
#           add new behavior for indenting (under_name)
#           add new option to set different color for server buffers and buffers with free content
# 2011-10-30, nils_2 <weechatter@arcor.de>:
#     v2.5: add new options "show_number_char" and "color_number_char",
#           add help-description for options
# 2011-08-24, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.4: add mouse support
# 2011-06-06, nils_2 <weechatter@arcor.de>:
#     v2.3: added: missed option "color_whitelist_default"
# 2011-03-23, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.2: fix color of nick prefix with WeeChat >= 0.3.5
# 2011-02-13, nils_2 <weechatter@arcor.de>:
#     v2.1: add options "color_whitelist_*"
# 2010-10-05, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.0: add options "sort" and "show_number"
# 2010-04-12, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.9: replace call to log() by length() to align buffer numbers
# 2010-04-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.8: fix bug with background color and option indenting_number
# 2010-04-02, Helios <helios@efemes.de>:
#     v1.7: add indenting_number option
# 2010-02-25, m4v <lambdae2@gmail.com>:
#     v1.6: add option to hide empty prefixes
# 2010-02-12, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.5: add optional nick prefix for buffers like IRC channels
# 2009-09-30, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.4: remove spaces for indenting when bar position is top/bottom
# 2009-06-14, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.3: add option "hide_merged_buffers"
# 2009-06-14, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.2: improve display with merged buffers
# 2009-05-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.1: sync with last API changes
# 2009-02-21, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.0: remove timer used to update bar item first time (not needed any more)
# 2009-02-17, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.9: fix bug with indenting of private buffers
# 2009-01-04, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.8: update syntax for command /set (comments)
# 2008-10-20, Jiri Golembiovsky <golemj@gmail.com>:
#     v0.7: add indenting option
# 2008-10-01, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.6: add default color for buffers, and color for current active buffer
# 2008-09-18, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.5: fix color for "low" level entry in hotlist
# 2008-09-18, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.4: rename option "show_category" to "short_names",
#           remove option "color_slash"
# 2008-09-15, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.3: fix bug with priority in hotlist (var not defined)
# 2008-09-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.2: add color for buffers with activity and config options for
#           colors, add config option to display/hide categories
# 2008-03-15, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.1: script creation
#
# Help about settings:
#   display all settings for script (or use iset.pl script to change settings):
#      /set buffers*
#   show help text for option buffers.look.whitelist_buffers:
#      /help buffers.look.whitelist_buffers
#
# Mouse-support (standard key bindings):
#   left mouse-button:
#       - click on a buffer to switch to selected buffer
#       - click on current buffer will do action jump_previously_visited_buffer
#       - drag a buffer and drop it on another position will move the buffer to position
#   right mouse-button:
#       - click on current buffer will do action jump_next_visited_buffer
#       - moving buffer to the left/right will close buffer.
#

use strict;
use Encode qw( decode encode );
# -----------------------------[ internal ]-------------------------------------
my $SCRIPT_NAME = "buffers";
my $SCRIPT_VERSION = "4.9";

my $BUFFERS_CONFIG_FILE_NAME = "buffers";
my $buffers_config_file;
my $cmd_buffers_whitelist= "buffers_whitelist";
my $cmd_buffers_detach   = "buffers_detach";

my %mouse_keys = ("\@item(buffers):button1*" => "hsignal:buffers_mouse",
                  "\@item(buffers):button2*" => "hsignal:buffers_mouse",
                  "\@bar(buffers):ctrl-wheelup" => "hsignal:buffers_mouse",
                  "\@bar(buffers):ctrl-wheeldown" => "hsignal:buffers_mouse");
my %options;
my %hotlist_level = (0 => "low", 1 => "message", 2 => "private", 3 => "highlight");
my @whitelist_buffers = ();
my @immune_detach_buffers= ();
my @detach_buffer_immediately= ();
my @buffers_focus = ();
my %buffers_timer = ();
my %Hooks = ();

# --------------------------------[ init ]--------------------------------------
weechat::register($SCRIPT_NAME, "Sebastien Helleu <flashcode\@flashtux.org>",
                  $SCRIPT_VERSION, "GPL3",
                  "Sidebar with list of buffers", "shutdown_cb", "");
my $weechat_version = weechat::info_get("version_number", "") || 0;

buffers_config_init();
buffers_config_read();

weechat::bar_item_new($SCRIPT_NAME, "build_buffers", "");
weechat::bar_new($SCRIPT_NAME, "0", "0", "root", "", "left", "columns_vertical",
                 "vertical", "0", "0", "default", "default", "default", "1",
                 $SCRIPT_NAME);

if ( check_bar_item() == 0 )
{
    weechat::command("", "/bar show " . $SCRIPT_NAME) if ( weechat::config_boolean($options{"toggle_bar"}) eq 1 );
}

weechat::hook_signal("buffer_opened", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_closed", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_merged", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_unmerged", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_moved", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_renamed", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_switch", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_hidden", "buffers_signal_buffer", "");  # WeeChat >= 0.4.4
weechat::hook_signal("buffer_unhidden", "buffers_signal_buffer", "");  # WeeChat >= 0.4.4
weechat::hook_signal("buffer_localvar_added", "buffers_signal_buffer", "");
weechat::hook_signal("buffer_localvar_changed", "buffers_signal_buffer", "");

weechat::hook_signal("window_switch", "buffers_signal_buffer", "");
weechat::hook_signal("hotlist_changed", "buffers_signal_hotlist", "");
#weechat::hook_command_run("/input switch_active_*", "buffers_signal_buffer", "");
weechat::bar_item_update($SCRIPT_NAME);


if ($weechat_version >= 0x00030600)
{
    weechat::hook_focus($SCRIPT_NAME, "buffers_focus_buffers", "");
    weechat::hook_hsignal("buffers_mouse", "buffers_hsignal_mouse", "");
    weechat::key_bind("mouse", \%mouse_keys);
}

weechat::hook_command($cmd_buffers_whitelist,
                      "add/del current buffer to/from buffers whitelist",
                      "[add] || [del] || [reset]",
                      "  add: add current buffer in configuration file\n".
                      "  del: delete current buffer from configuration file\n".
                      "reset: reset all buffers from configuration file ".
                      "(no confirmation!)\n\n".
                      "Examples:\n".
                      "/$cmd_buffers_whitelist add\n",
                      "add %-||".
                      "del %-||".
                      "reset %-",
                      "buffers_cmd_whitelist", "");
weechat::hook_command($cmd_buffers_detach,
                      "add/del current buffer to/from buffers detach",
                      "[add] || [del] || [reset]",
                      "  add: add current buffer in configuration file\n".
                      "  del: delete current buffer from configuration file\n".
                      "reset: reset all buffers from configuration file ".
                      "(no confirmation!)\n\n".
                      "Examples:\n".
                      "/$cmd_buffers_detach add\n",
                      "add %-||".
                      "del %-||".
                      "reset %-",
                      "buffers_cmd_detach", "");

if ($weechat_version >= 0x00030800)
{
    weechat::hook_config("buffers.look.detach", "hook_timer_detach", "");
    if (weechat::config_integer($options{"detach"}) > 0)
    {
        $Hooks{timer_detach} = weechat::hook_timer(weechat::config_integer($options{"detach"}) * 1000,
                                                   60, 0, "buffers_signal_hotlist", "");
    }
}

weechat::hook_config("buffers.look.show_lag", "hook_timer_lag", "");

if (weechat::config_boolean($options{"show_lag"}))
{
    $Hooks{timer_lag} = weechat::hook_timer(
        weechat::config_integer(weechat::config_get("irc.network.lag_refresh_interval")) * 1000,
        0, 0, "buffers_signal_hotlist", "");
}

# -------------------------------- [ command ] --------------------------------
sub buffers_cmd_whitelist
{
my ( $data, $buffer, $args ) = @_;
    $args = lc($args);
    my $buffers_whitelist = weechat::config_string( weechat::config_get("buffers.look.whitelist_buffers") );
    return weechat::WEECHAT_RC_OK if ( $buffers_whitelist eq "" and $args eq "del" or $buffers_whitelist eq "" and $args eq "reset" );
    my @buffers_list = split( /,/, $buffers_whitelist );
    # get buffers name
    my $infolist = weechat::infolist_get("buffer", weechat::current_buffer(), "");
    weechat::infolist_next($infolist);
    my $buffers_name = weechat::infolist_string($infolist, "name");
    weechat::infolist_free($infolist);
    return weechat::WEECHAT_RC_OK if ( $buffers_name eq "" );                   # should never happen

    if ( $args eq "add" )
    {
        return weechat::WEECHAT_RC_OK if ( grep /^$buffers_name$/, @buffers_list );     # check if buffer already in list
        push @buffers_list, ( $buffers_name );
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), $buffers_list, 1);
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" added to buffers whitelist");
    }
    elsif ( $args eq "del" )
    {
        return weechat::WEECHAT_RC_OK unless ( grep /^$buffers_name$/, @buffers_list );     # check if buffer is in list
        @buffers_list = grep {$_ ne $buffers_name} @buffers_list;                           # delete entry
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), $buffers_list, 1);
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" deleted from buffers whitelist");
    }
    elsif ( $args eq "reset" )
    {
        return weechat::WEECHAT_RC_OK if ( $buffers_whitelist eq "" );
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), "", 1);
        weechat::print(weechat::current_buffer(), "buffers whitelist is empty, now...");
    }
    return weechat::WEECHAT_RC_OK;
}
sub buffers_cmd_detach
{
    my ( $data, $buffer, $args ) = @_;
    $args = lc($args);
    my $immune_detach_buffers = weechat::config_string( weechat::config_get("buffers.look.immune_detach_buffers") );
    return weechat::WEECHAT_RC_OK if ( $immune_detach_buffers eq "" and $args eq "del" or $immune_detach_buffers eq "" and $args eq "reset" );

    my @buffers_list = split( /,/, $immune_detach_buffers );
    # get buffers name
    my $infolist = weechat::infolist_get("buffer", weechat::current_buffer(), "");
    weechat::infolist_next($infolist);
    my $buffers_name = weechat::infolist_string($infolist, "name");
    weechat::infolist_free($infolist);
    return weechat::WEECHAT_RC_OK if ( $buffers_name eq "" );                   # should never happen

    if ( $args eq "add" )
    {
        return weechat::WEECHAT_RC_OK if ( grep /^$buffers_name$/, @buffers_list );     # check if buffer already in list
        push @buffers_list, ( $buffers_name );
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), $buffers_list, 1);
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" added to immune detach buffers");
    }
    elsif ( $args eq "del" )
    {
        return weechat::WEECHAT_RC_OK unless ( grep /^$buffers_name$/, @buffers_list );     # check if buffer is in list
        @buffers_list = grep {$_ ne $buffers_name} @buffers_list;                           # delete entry
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), $buffers_list, 1);
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" deleted from immune detach buffers");
    }
    elsif ( $args eq "reset" )
    {
        return weechat::WEECHAT_RC_OK if ( $immune_detach_buffers eq "" );
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), "", 1);
        weechat::print(weechat::current_buffer(), "immune detach buffers is empty, now...");
    }
    return weechat::WEECHAT_RC_OK;
}

sub create_whitelist
{
    my @buffers_list = @{$_[0]};
    my $buffers_list = "";
        foreach (@buffers_list)
        {
            $buffers_list .= $_ .",";
        }
        # remove last ","
        chop $buffers_list;
    return $buffers_list;
}

# -------------------------------- [ config ] --------------------------------
sub hook_timer_detach
{
    my $detach = $_[2];
    if ( $detach eq 0 )
    {
        weechat::unhook($Hooks{timer_detach}) if $Hooks{timer_detach};
        $Hooks{timer_detach} = "";
    }
    else
    {
        weechat::unhook($Hooks{timer_detach}) if $Hooks{timer_detach};
        $Hooks{timer_detach} = weechat::hook_timer( weechat::config_integer( $options{"detach"}) * 1000, 60, 0, "buffers_signal_hotlist", "");
    }
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub hook_timer_lag
{
    my $lag = $_[2];
    if ( $lag eq "off" )
    {
        weechat::unhook($Hooks{timer_lag}) if $Hooks{timer_lag};
        $Hooks{timer_lag} = "";
    }
    else
    {
        weechat::unhook($Hooks{timer_lag}) if $Hooks{timer_lag};
        $Hooks{timer_lag} = weechat::hook_timer( weechat::config_integer(weechat::config_get("irc.network.lag_refresh_interval")) * 1000, 0, 0, "buffers_signal_hotlist", "");
    }
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub buffers_config_read
{
    return weechat::config_read($buffers_config_file) if ($buffers_config_file ne "");
}
sub buffers_config_write
{
    return weechat::config_write($buffers_config_file) if ($buffers_config_file ne "");
}
sub buffers_config_reload_cb
{
    my ($data, $config_file) = ($_[0], $_[1]);
    return weechat::config_reload($config_file)
}
sub buffers_config_init
{
    $buffers_config_file = weechat::config_new($BUFFERS_CONFIG_FILE_NAME,
                                               "buffers_config_reload_cb", "");
    return if ($buffers_config_file eq "");

my %default_options_color =
("color_current_fg" => [
     "current_fg", "color",
     "foreground color for current buffer",
     "", 0, 0, "lightcyan", "lightcyan", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_current_bg" => [
     "current_bg", "color",
     "background color for current buffer",
     "", 0, 0, "red", "red", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_default_fg" => [
     "default_fg", "color",
     "default foreground color for buffer name",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_default_bg" => [
     "default_bg", "color",
     "default background color for buffer name",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_highlight_fg" => [
     "hotlist_highlight_fg", "color",
     "change foreground color of buffer name if a highlight messaged received",
     "", 0, 0, "magenta", "magenta", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_highlight_bg" => [
     "hotlist_highlight_bg", "color",
     "change background color of buffer name if a highlight messaged received",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_low_fg" => [
     "hotlist_low_fg", "color",
     "change foreground color of buffer name if a low message received",
     "", 0, 0, "white", "white", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_low_bg" => [
     "hotlist_low_bg", "color",
     "change background color of buffer name if a low message received",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_message_fg" => [
     "hotlist_message_fg", "color",
     "change foreground color of buffer name if a normal message received",
     "", 0, 0, "yellow", "yellow", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_message_bg" => [
     "hotlist_message_bg", "color",
     "change background color of buffer name if a normal message received",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_private_fg" => [
     "hotlist_private_fg", "color",
     "change foreground color of buffer name if a private message received",
     "", 0, 0, "lightgreen", "lightgreen", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_hotlist_private_bg" => [
     "hotlist_private_bg", "color",
     "change background color of buffer name if a private message received",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_number" => [
     "number", "color",
     "color for buffer number",
     "", 0, 0, "lightgreen", "lightgreen", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_number_char" => [
     "number_char", "color",
     "color for buffer number char",
     "", 0, 0, "lightgreen", "lightgreen", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_default_fg" => [
     "whitelist_default_fg", "color",
     "default foreground color for whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_default_bg" => [
     "whitelist_default_bg", "color",
     "default background color for whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_low_fg" => [
     "whitelist_low_fg", "color",
     "low color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_low_bg" => [
     "whitelist_low_bg", "color",
     "low color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_message_fg" => [
     "whitelist_message_fg", "color",
     "message color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_message_bg" => [
     "whitelist_message_bg", "color",
     "message color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_private_fg" => [
     "whitelist_private_fg", "color",
     "private color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_private_bg" => [
     "whitelist_private_bg", "color",
     "private color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_highlight_fg" => [
     "whitelist_highlight_fg", "color",
     "highlight color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_whitelist_highlight_bg" => [
     "whitelist_highlight_bg", "color",
     "highlight color of whitelist buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_none_channel_fg" => [
     "none_channel_fg", "color",
     "foreground color for none channel buffer (e.g.: core/server/plugin ".
     "buffer)",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_none_channel_bg" => [
     "none_channel_bg", "color",
     "background color for none channel buffer (e.g.: core/server/plugin ".
     "buffer)",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_default_fg" => [
     "queries_default_fg", "color",
     "foreground color for query buffer without message",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_default_bg" => [
     "queries_default_bg", "color",
     "background color for query buffer without message",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_message_fg" => [
     "queries_message_fg", "color",
     "foreground color for query buffer with unread message",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_message_bg" => [
     "queries_message_bg", "color",
     "background color for query buffer with unread message",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_highlight_fg" => [
     "queries_highlight_fg", "color",
     "foreground color for query buffer with unread highlight",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "queries_highlight_bg" => [
     "queries_highlight_bg", "color",
     "background color for query buffer with unread highlight",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_prefix_bufname" => [
     "prefix_bufname", "color",
     "color for prefix of buffer name",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "color_suffix_bufname" => [
     "suffix_bufname", "color",
     "color for suffix of buffer name",
     "", 0, 0, "default", "default", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
);

my %default_options_look =
(
 "hotlist_counter" => [
     "hotlist_counter", "boolean",
     "show number of message for the buffer (this option needs WeeChat >= ".
     "0.3.5). The relevant option for notification is \"weechat.look.".
     "buffer_notify_default\"",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_lag" => [
     "show_lag", "boolean",
     "show lag behind server name. This option is using \"irc.color.".
     "item_lag_finished\", ".
     "\"irc.network.lag_min_show\" and \"irc.network.lag_refresh_interval\"",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "look_whitelist_buffers" => [
     "whitelist_buffers", "string",
     "comma separated list of buffers for using a different color scheme ".
     "(for example: freenode.#weechat,freenode.#weechat-fr)",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config_whitelist", "", "", ""
 ],
 "hide_merged_buffers" => [
     "hide_merged_buffers", "integer",
     "hide merged buffers. The value determines which merged buffers should ".
     "be hidden, keepserver meaning 'all except server buffers'. Other values ".
     "correspondent to the buffer type.",
     "server|channel|private|keepserver|all|none", 0, 0, "none", "none", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "indenting" => [
     "indenting", "integer", "use indenting for channel and query buffers. ".
     "This option only takes effect if bar is left/right positioned",
     "off|on|under_name", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "indenting_number" => [
     "indenting_number", "boolean",
     "use indenting for numbers. This option only takes effect if bar is ".
     "left/right positioned",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "short_names" => [
     "short_names", "boolean",
     "display short names (remove text before first \".\" in buffer name)",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_number" => [
     "show_number", "boolean",
     "display buffer number in front of buffer name",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_number_char" => [
     "number_char", "string",
     "display a char behind buffer number",
     "", 0, 0, ".", ".", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_prefix_bufname" => [
     "prefix_bufname", "string",
     "prefix displayed in front of buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_suffix_bufname" => [
     "suffix_bufname", "string",
     "suffix displayed at end of buffer name",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_prefix" => [
     "prefix", "boolean",
     "displays your prefix for channel in front of buffer name",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "show_prefix_empty" => [
     "prefix_empty", "boolean",
     "use a placeholder for channels without prefix",
     "", 0, 0, "on", "on", 0,
     "", "",  "buffers_signal_config", "", "", ""
 ],
 "show_prefix_query" => [
     "prefix_for_query", "string",
     "prefix displayed in front of query buffer",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "sort" => [
     "sort", "integer",
     "sort buffer-list by \"number\" or \"name\"",
     "number|name", 0, 0, "number", "number", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "core_to_front" => [
     "core_to_front", "boolean",
     "core buffer and buffers with free content will be listed first. ".
     "Take only effect if buffer sort is by name",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "jump_prev_next_visited_buffer" => [
     "jump_prev_next_visited_buffer", "boolean",
     "jump to previously or next visited buffer if you click with ".
     "left/right mouse button on currently visiting buffer",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "name_size_max" => [
     "name_size_max", "integer",
     "maximum size of buffer name. 0 means no limitation",
     "", 0, 256, 0, 0, 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "name_crop_suffix" => [
     "name_crop_suffix", "string",
     "contains an optional char(s) that is appended when buffer name is ".
     "shortened",
     "", 0, 0, "+", "+", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "detach" => [
     "detach", "integer",
     "detach buffer from buffers list after a specific period of time ".
     "(in seconds) without action (weechat ≥ 0.3.8 required) (0 means \"off\")",
     "", 0, 31536000, 0, "number", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "immune_detach_buffers" => [
     "immune_detach_buffers", "string",
     "comma separated list of buffers to NOT automatically detach. ".
     "Allows \"*\" wildcard. Ex: \"BitlBee,freenode.*\"",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config_immune_detach_buffers", "", "", ""
 ],
 "detach_query" => [
     "detach_query", "boolean",
     "query buffer will be detached",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "detach_buffer_immediately" => [
     "detach_buffer_immediately", "string",
     "comma separated list of buffers to detach immediately. A query and ".
     "highlight message will attach buffer again. Allows \"*\" wildcard. ".
     "Ex: \"BitlBee,freenode.*\"",
     "", 0, 0, "", "", 0,
     "", "", "buffers_signal_config_detach_buffer_immediately", "", "", ""
 ],
 "detach_free_content" => [
     "detach_free_content", "boolean",
     "buffers with free content will be detached (Ex: iset, chanmon)",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "detach_displayed_buffers" => [
     "detach_displayed_buffers", "boolean",
     "buffers displayed in a (split) window will be detached",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "detach_display_window_number" => [
     "detach_display_window_number", "boolean",
     "window number will be add, behind buffer name (this option takes only ".
     "effect with \"detach_displayed_buffers\" option)",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "mark_inactive" => [
     "mark_inactive", "boolean",
     "if option is \"on\", inactive buffers (those you are not in) will have ".
     "parentheses around them. An inactive buffer will not be detached.",
     "", 0, 0, "off", "off", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "toggle_bar" => [
     "toggle_bar", "boolean",
     "if option is \"on\", buffers bar will hide/show when script is ".
     "(un)loaded.",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "mouse_move_buffer" => [
     "mouse_move_buffer", "boolean",
     "if option is \"on\", mouse gestures (drag & drop) can move buffers in list.",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
 "mouse_wheel" => [
     "mouse_wheel", "boolean",
     "if option is \"on\", mouse wheel jumps to previous/next buffer in list.",
     "", 0, 0, "on", "on", 0,
     "", "", "buffers_signal_config", "", "", ""
 ],
);
    # section "color"
    my $section_color = weechat::config_new_section(
        $buffers_config_file,
        "color", 0, 0, "", "", "", "", "", "", "", "", "", "");
    if ($section_color eq "")
    {
        weechat::config_free($buffers_config_file);
        return;
    }
    foreach my $option (keys %default_options_color)
    {
        $options{$option} = weechat::config_new_option(
            $buffers_config_file,
            $section_color,
            $default_options_color{$option}[0],
            $default_options_color{$option}[1],
            $default_options_color{$option}[2],
            $default_options_color{$option}[3],
            $default_options_color{$option}[4],
            $default_options_color{$option}[5],
            $default_options_color{$option}[6],
            $default_options_color{$option}[7],
            $default_options_color{$option}[8],
            $default_options_color{$option}[9],
            $default_options_color{$option}[10],
            $default_options_color{$option}[11],
            $default_options_color{$option}[12],
            $default_options_color{$option}[13],
            $default_options_color{$option}[14]);
    }

    # section "look"
    my $section_look = weechat::config_new_section(
        $buffers_config_file,
        "look", 0, 0, "", "", "", "", "", "", "", "", "", "");
    if ($section_look eq "")
    {
        weechat::config_free($buffers_config_file);
        return;
    }
    foreach my $option (keys %default_options_look)
    {
        $options{$option} = weechat::config_new_option(
            $buffers_config_file,
            $section_look,
            $default_options_look{$option}[0],
            $default_options_look{$option}[1],
            $default_options_look{$option}[2],
            $default_options_look{$option}[3],
            $default_options_look{$option}[4],
            $default_options_look{$option}[5],
            $default_options_look{$option}[6],
            $default_options_look{$option}[7],
            $default_options_look{$option}[8],
            $default_options_look{$option}[9],
            $default_options_look{$option}[10],
            $default_options_look{$option}[11],
            $default_options_look{$option}[12],
            $default_options_look{$option}[13],
            $default_options_look{$option}[14],
            $default_options_look{$option}[15]);
    }
}

sub build_buffers
{
    my $str = "";

    # get bar position (left/right/top/bottom)
    my $position = "left";
    my $option_position = weechat::config_get("weechat.bar.buffers.position");
    if ($option_position ne "")
    {
        $position = weechat::config_string($option_position);
    }

    # read hotlist
    my %hotlist;
    my $infolist = weechat::infolist_get("hotlist", "", "");
    while (weechat::infolist_next($infolist))
    {
        $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")} =
            weechat::infolist_integer($infolist, "priority");
        if ( weechat::config_boolean( $options{"hotlist_counter"} ) eq 1 and $weechat_version >= 0x00030500)
        {
            $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")."_count_00"} =
                weechat::infolist_integer($infolist, "count_00");   # low message
            $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")."_count_01"} =
                weechat::infolist_integer($infolist, "count_01");   # channel message
            $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")."_count_02"} =
                weechat::infolist_integer($infolist, "count_02");   # private message
            $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")."_count_03"} =
                weechat::infolist_integer($infolist, "count_03");   # highlight message
        }
    }
    weechat::infolist_free($infolist);

    # read buffers list
    @buffers_focus = ();
    my @buffers;
    my @current1 = ();
    my @current2 = ();
    my $old_number = -1;
    my $max_number = 0;
    my $max_number_digits = 0;
    my $active_seen = 0;
    $infolist = weechat::infolist_get("buffer", "", "");
    while (weechat::infolist_next($infolist))
    {
        # ignore hidden buffers (WeeChat >= 0.4.4)
        if ($weechat_version >= 0x00040400)
        {
            next if (weechat::infolist_integer($infolist, "hidden"));
        }
        my $buffer;
        my $number = weechat::infolist_integer($infolist, "number");
        if ($number ne $old_number)
        {
            @buffers = (@buffers, @current2, @current1);
            @current1 = ();
            @current2 = ();
            $active_seen = 0;
        }
        if ($number > $max_number)
        {
            $max_number = $number;
        }
        $old_number = $number;
        my $active = weechat::infolist_integer($infolist, "active");
        if ($active)
        {
            $active_seen = 1;
        }
        $buffer->{"pointer"} = weechat::infolist_pointer($infolist, "pointer");
        $buffer->{"number"} = $number;
        $buffer->{"active"} = $active;
        $buffer->{"current_buffer"} = weechat::infolist_integer($infolist, "current_buffer");
        $buffer->{"num_displayed"} = weechat::infolist_integer($infolist, "num_displayed");
        $buffer->{"plugin_name"} = weechat::infolist_string($infolist, "plugin_name");
        $buffer->{"name"} = weechat::infolist_string($infolist, "name");
        $buffer->{"short_name"} = weechat::infolist_string($infolist, "short_name");
        $buffer->{"full_name"} = $buffer->{"plugin_name"}.".".$buffer->{"name"};
        $buffer->{"type"} = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type");
        #weechat::print("", $buffer->{"type"});

        # check if buffer is active (or maybe a /part, /kick channel)
        if ($buffer->{"type"} eq "channel" and weechat::config_boolean( $options{"mark_inactive"} ) eq 1)
        {
            my $server = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_server");
            my $channel = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_channel");
            my $infolist_channel = weechat::infolist_get("irc_channel", "", $server.",".$channel);
            if ($infolist_channel)
            {
                weechat::infolist_next($infolist_channel);
                $buffer->{"nicks_count"} = weechat::infolist_integer($infolist_channel, "nicks_count");
            }else
            {
                $buffer->{"nicks_count"} = 0;
            }
            weechat::infolist_free($infolist_channel);
        }

        my $result = check_immune_detached_buffers($buffer->{"name"});          # checking for wildcard 

        next if ( check_detach_buffer_immediately($buffer->{"name"}) eq 1
                 and $buffer->{"current_buffer"} eq 0
                 and ( not exists $hotlist{$buffer->{"pointer"}} or $hotlist{$buffer->{"pointer"}} < 2) );          # checking for buffer to immediately detach

        unless ($result)
        {
            my $detach_time = weechat::config_integer( $options{"detach"});
            my $current_time = time();
            # set timer for buffers with no hotlist action
            $buffers_timer{$buffer->{"pointer"}} = $current_time
             if ( not exists $hotlist{$buffer->{"pointer"}}
             and $buffer->{"type"} eq "channel"
             and not exists $buffers_timer{$buffer->{"pointer"}}
             and $detach_time > 0);

            $buffers_timer{$buffer->{"pointer"}} = $current_time
            if (weechat::config_boolean($options{"detach_query"}) eq 1
            and not exists $hotlist{$buffer->{"pointer"}}
            and $buffer->{"type"} eq "private"
            and not exists $buffers_timer{$buffer->{"pointer"}}
            and $detach_time > 0);

            $detach_time = 0
            if (weechat::config_boolean($options{"detach_query"}) eq 0
            and $buffer->{"type"} eq "private");

            # free content buffer
            $buffers_timer{$buffer->{"pointer"}} = $current_time
            if (weechat::config_boolean($options{"detach_free_content"}) eq 1
            and not exists $hotlist{$buffer->{"pointer"}}
            and $buffer->{"type"} eq ""
            and not exists $buffers_timer{$buffer->{"pointer"}}
            and $detach_time > 0);
            $detach_time = 0
            if (weechat::config_boolean($options{"detach_free_content"}) eq 0
            and $buffer->{"type"} eq "");

            $detach_time = 0 if (weechat::config_boolean($options{"mark_inactive"}) eq 1 and defined $buffer->{"nicks_count"} and $buffer->{"nicks_count"} == 0);

            # check for detach
            unless ( $buffer->{"current_buffer"} eq 0
            and not exists $hotlist{$buffer->{"pointer"}}
#            and $buffer->{"type"} eq "channel"
            and exists $buffers_timer{$buffer->{"pointer"}}
            and $detach_time > 0
            and $weechat_version >= 0x00030800
            and $current_time - $buffers_timer{$buffer->{"pointer"}} >= $detach_time)
            {
                if ($active_seen)
                {
                    push(@current2, $buffer);
                }
                else
                {
                    push(@current1, $buffer);
                }
            }
            elsif ( $buffer->{"current_buffer"} eq 0
            and not exists $hotlist{$buffer->{"pointer"}}
#            and $buffer->{"type"} eq "channel"
            and exists $buffers_timer{$buffer->{"pointer"}}
            and $detach_time > 0
            and $weechat_version >= 0x00030800
            and $current_time - $buffers_timer{$buffer->{"pointer"}} >= $detach_time)
            {   # check for option detach_displayed_buffers and if buffer is displayed in a split window
                if ( $buffer->{"num_displayed"} eq 1
                    and weechat::config_boolean($options{"detach_displayed_buffers"}) eq 0 )
                {
                    my $infolist_window = weechat::infolist_get("window", "", "");
                    while (weechat::infolist_next($infolist_window))
                    {
                        my $buffer_ptr = weechat::infolist_pointer($infolist_window, "buffer");
                        if ($buffer_ptr eq $buffer->{"pointer"})
                        {
                            $buffer->{"window"} = weechat::infolist_integer($infolist_window, "number");
                        }
                    }
                    weechat::infolist_free($infolist_window);

                    push(@current2, $buffer);
                }
            }
        }
        else    # buffer in "immune_detach_buffers"
        {
                if ($active_seen)
                {
                    push(@current2, $buffer);
                }
                else
                {
                    push(@current1, $buffer);
                }
        }
    }   # while end


    if ($max_number >= 1)
    {
        $max_number_digits = length(int($max_number));
    }
    @buffers = (@buffers, @current2, @current1);
    weechat::infolist_free($infolist);

    # sort buffers by number, name or shortname
    my %sorted_buffers;
    if (1)
    {
        my $number = 0;
        for my $buffer (@buffers)
        {
            my $key;
            if (weechat::config_integer( $options{"sort"} ) eq 1) # number = 0; name = 1
            {
                my $name = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_custom_name");
                if (not defined $name or $name eq "") {
                    if (weechat::config_boolean( $options{"short_names"} ) eq 1) {
                        $name = $buffer->{"short_name"};
                    } else {
                        $name = $buffer->{"name"};
                    }
                }
                if (weechat::config_integer($options{"name_size_max"}) >= 1){
                    $name = encode("UTF-8", substr(decode("UTF-8", $name), 0, weechat::config_integer($options{"name_size_max"})));
                }
                if ( weechat::config_boolean($options{"core_to_front"}) eq 1)
                {
                    if ( (weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "channel" ) and ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "private") )
                    {
                        my $type = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type");
                        if ( $type eq "" and $name ne "weechat")
                        {
                            $name = " " . $name
                        }else
                        {
                            $name = "  " . $name;
                        }
                    }
                }
                $key = sprintf("%s%08d", lc($name), $buffer->{"number"});
            }
            else
            {
                $key = sprintf("%08d", $number);
            }
            $sorted_buffers{$key} = $buffer;
            $number++;
        }
    }

    # build string with buffers
    $old_number = -1;
    foreach my $key (sort keys %sorted_buffers)
    {
        my $buffer = $sorted_buffers{$key};

        if ( weechat::config_string($options{"hide_merged_buffers"}) eq "server" )
        {
            # buffer type "server" or merged with core?
            if ( ($buffer->{"type"} eq "server" or $buffer->{"plugin_name"} eq "core") && (! $buffer->{"active"}) )
            {
                next;
            }
        }
        if ( weechat::config_string($options{"hide_merged_buffers"}) eq "channel" )
        {
            # buffer type "channel" or merged with core?
            if ( ($buffer->{"type"} eq "channel" or $buffer->{"plugin_name"} eq "core") && (! $buffer->{"active"}) )
            {
                next;
            }
        }
        if ( weechat::config_string($options{"hide_merged_buffers"}) eq "private" )
        {
            # buffer type "private" or merged with core?
            if ( ($buffer->{"type"} eq "private" or $buffer->{"plugin_name"} eq "core") && (! $buffer->{"active"}) )
            {
                next;
            }
        }
        if ( weechat::config_string($options{"hide_merged_buffers"}) eq "keepserver" )
        {
            if ( ($buffer->{"type"} ne "server" or $buffer->{"plugin_name"} eq "core") && (! $buffer->{"active"}) )
            {
                next;
            }
        }
        if ( weechat::config_string($options{"hide_merged_buffers"}) eq "all" )
        {
            if ( ! $buffer->{"active"} )
            {
                next;
            }
        }

        push(@buffers_focus, $buffer);                                          # buffer > buffers_focus, for mouse support
        my $color = "";
        my $bg = "";

        $color = weechat::config_color( $options{"color_default_fg"} );
        $bg = weechat::config_color( $options{"color_default_bg"} );

        if ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "private" )
        {
            if ( (weechat::config_color($options{"queries_default_bg"})) ne "default" || (weechat::config_color($options{"queries_default_fg"})) ne "default" )
            {
              $bg = weechat::config_color( $options{"queries_default_bg"} );
              $color = weechat::config_color( $options{"queries_default_fg"} );
            }
        }
        # check for core and buffer with free content
        if ( (weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "channel" ) and ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "private") )
        {
            $color = weechat::config_color( $options{"color_none_channel_fg"} );
            $bg = weechat::config_color( $options{"color_none_channel_bg"} );
        }
        # default whitelist buffer?
        if (grep {$_ eq $buffer->{"name"}} @whitelist_buffers)
        {
                $color = weechat::config_color( $options{"color_whitelist_default_fg"} );
                $bg = weechat::config_color( $options{"color_whitelist_default_bg"} );
        }

        $color = "default" if ($color eq "");

        # color for channel and query buffer
        if (exists $hotlist{$buffer->{"pointer"}})
        {
        delete $buffers_timer{$buffer->{"pointer"}};
            # check if buffer is in whitelist buffer
            if (grep {$_ eq $buffer->{"name"}} @whitelist_buffers)
            {
                $bg = weechat::config_color( $options{"color_whitelist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                $color = weechat::config_color( $options{"color_whitelist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"} );
            }
            elsif ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "private" )
            {
                # queries_default_fg/bg and buffers.color.queries_message_fg/bg
                if ( (weechat::config_color($options{"queries_highlight_fg"})) ne "default" ||
                      (weechat::config_color($options{"queries_highlight_bg"})) ne "default" ||
                       (weechat::config_color($options{"queries_message_fg"})) ne "default" ||
                        (weechat::config_color($options{"queries_message_bg"})) ne "default" )
                {
                  if ( ($hotlist{$buffer->{"pointer"}}) == 2 )
                  {
                      $bg = weechat::config_color( $options{"queries_message_bg"} );
                      $color = weechat::config_color( $options{"queries_message_fg"} );
                  }

                  elsif ( ($hotlist{$buffer->{"pointer"}}) == 3 )
                  {
                      $bg = weechat::config_color( $options{"queries_highlight_bg"} );
                      $color = weechat::config_color( $options{"queries_highlight_fg"} );
                  }
                }else
                {
                      $bg = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                      $color = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"}  );
                }
            }else
            {
                      $bg = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                      $color = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"}  );
            }
        }

        if ($buffer->{"current_buffer"})
        {
            $color = weechat::config_color( $options{"color_current_fg"} );
            $bg = weechat::config_color( $options{"color_current_bg"} );
        }
        my $color_bg = "";
        $color_bg = weechat::color(",".$bg) if ($bg ne "");

        # create channel number for output
        if ( weechat::config_string( $options{"show_prefix_bufname"} ) ne "" )
        {
            $str .= $color_bg .
                    weechat::color( weechat::config_color( $options{"color_prefix_bufname"} ) ).
                    weechat::config_string( $options{"show_prefix_bufname"} ).
                    weechat::color("default");
        }

        if ( weechat::config_boolean( $options{"show_number"} ) eq 1 )   # on
        {
            if (( weechat::config_boolean( $options{"indenting_number"} ) eq 1)
                && (($position eq "left") || ($position eq "right")))
            {
                $str .= weechat::color("default").$color_bg
                    .(" " x ($max_number_digits - length(int($buffer->{"number"}))));
            }
            if ($old_number ne $buffer->{"number"})
            {
                $str .= weechat::color( weechat::config_color( $options{"color_number"} ) )
                    .$color_bg
                    .$buffer->{"number"}
                    .weechat::color("default")
                    .$color_bg
                    .weechat::color( weechat::config_color( $options{"color_number_char"} ) )
                    .weechat::config_string( $options{"show_number_char"} )
                    .$color_bg;
            }
            else
            {
                my $indent = "";
                $indent = ((" " x length($buffer->{"number"}))." ") if (($position eq "left") || ($position eq "right"));
                $str .= weechat::color("default")
                    .$color_bg
                    .$indent;
            }
        }

        if (( weechat::config_integer( $options{"indenting"} ) ne 0 )            # indenting NOT off
            && (($position eq "left") || ($position eq "right")))
        {
            my $type = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type");
            if (($type eq "channel") || ($type eq "private"))
            {
                if ( weechat::config_integer( $options{"indenting"} ) eq 1 )
                {
                    $str .= "  ";
                }
                elsif ( (weechat::config_integer($options{"indenting"}) eq 2) and (weechat::config_integer($options{"indenting_number"}) eq 0) )        #under_name
                {
                    if ( weechat::config_boolean( $options{"show_number"} ) eq 0 )
                    {
                      $str .= "  ";
                    }else
                    {
                      $str .= ( (" " x ( $max_number_digits - length($buffer->{"number"}) ))." " );
                    }
                }
            }
        }

        $str .= weechat::config_string( $options{"show_prefix_query"}) if (weechat::config_string( $options{"show_prefix_query"} ) ne "" and  $buffer->{"type"} eq "private");

        if (weechat::config_boolean( $options{"show_prefix"} ) eq 1)
        {
            my $nickname = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_nick");
            if ($nickname ne "")
            {
                # with version >= 0.3.2, this infolist will return only nick
                # with older versions, whole nicklist is returned for buffer, and this can be very slow
                my $infolist_nick = weechat::infolist_get("nicklist", $buffer->{"pointer"}, "nick_".$nickname);
                if ($infolist_nick ne "")
                {
                    while (weechat::infolist_next($infolist_nick))
                    {
                        if ((weechat::infolist_string($infolist_nick, "type") eq "nick")
                            && (weechat::infolist_string($infolist_nick, "name") eq $nickname))
                        {
                            my $prefix = weechat::infolist_string($infolist_nick, "prefix");
                            if (($prefix ne " ") or (weechat::config_boolean( $options{"show_prefix_empty"} ) eq 1))
                            {
                                # with version >= 0.3.5, it is now a color name (for older versions: option name with color)
                                if (int($weechat_version) >= 0x00030500)
                                {
                                    $str .= weechat::color(weechat::infolist_string($infolist_nick, "prefix_color"));
                                }
                                else
                                {
                                    $str .= weechat::color(weechat::config_color(
                                                               weechat::config_get(
                                                                   weechat::infolist_string($infolist_nick, "prefix_color"))));
                                }
                                $str .= $prefix;
                            }
                            last;
                        }
                    }
                    weechat::infolist_free($infolist_nick);
                }
            }
        }
        if ($buffer->{"type"} eq "channel" and weechat::config_boolean( $options{"mark_inactive"} ) eq 1 and $buffer->{"nicks_count"} == 0)
        {
            $str .= "(";
        }

        $str .= weechat::color($color) . weechat::color(",".$bg);

        my $name = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_custom_name");
        if (not defined $name or $name eq "")
        {
            if (weechat::config_boolean( $options{"short_names"} ) eq 1) {
                $name = $buffer->{"short_name"};
            } else {
                $name = $buffer->{"name"};
            }
        }

        if (weechat::config_integer($options{"name_size_max"}) >= 1)                # check max_size of buffer name
        {
            $str .= encode("UTF-8", substr(decode("UTF-8", $name), 0, weechat::config_integer($options{"name_size_max"})));
            $str .= weechat::color(weechat::config_color( $options{"color_number_char"})).weechat::config_string($options{"name_crop_suffix"}) if (length($name) > weechat::config_integer($options{"name_size_max"}));
            $str .= add_inactive_parentless($buffer->{"type"}, $buffer->{"nicks_count"});
            $str .= add_hotlist_count($buffer->{"pointer"}, %hotlist);
        }
        else
        {
            $str .= $name;
            $str .= add_inactive_parentless($buffer->{"type"}, $buffer->{"nicks_count"});
            $str .= add_hotlist_count($buffer->{"pointer"}, %hotlist);
        }

        if ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "server" and weechat::config_boolean($options{"show_lag"}) eq 1)
        {
            my $color_lag = weechat::config_color(weechat::config_get("irc.color.item_lag_finished"));
            my $min_lag = weechat::config_integer(weechat::config_get("irc.network.lag_min_show"));
            my $infolist_server = weechat::infolist_get("irc_server", "", $buffer->{"short_name"});
            weechat::infolist_next($infolist_server);
            my $lag = (weechat::infolist_integer($infolist_server, "lag"));
            weechat::infolist_free($infolist_server);
            if ( int($lag) > int($min_lag) )
            {
                $lag = $lag / 1000;
                $str .= weechat::color("default") . " (" . weechat::color($color_lag) . $lag . weechat::color("default") . ")";
            }
        }
        if (weechat::config_boolean($options{"detach_displayed_buffers"}) eq 0
            and weechat::config_boolean($options{"detach_display_window_number"}) eq 1)
        {
            if ($buffer->{"window"})
            {
                $str .= weechat::color("default") . " (" . weechat::color(weechat::config_color( $options{"color_number"})) . $buffer->{"window"} . weechat::color("default") . ")";
            }
        }
        $str .= weechat::color("default");

        if ( weechat::config_string( $options{"show_suffix_bufname"} ) ne "" )
        {
            $str .= weechat::color( weechat::config_color( $options{"color_suffix_bufname"} ) ).
                    weechat::config_string( $options{"show_suffix_bufname"} ).
                    weechat::color("default");
        }

        $str .= "\n";
        $old_number = $buffer->{"number"};
    }

    # remove spaces and/or linefeed at the end
    $str =~ s/\s+$//;
    chomp($str);
    return $str;
}

sub add_inactive_parentless
{
my ($buf_type, $buf_nicks_count) = @_;
my $str = "";
    if ($buf_type eq "channel" and weechat::config_boolean( $options{"mark_inactive"} ) eq 1 and $buf_nicks_count == 0)
    {
        $str .= weechat::color(weechat::config_color( $options{"color_number_char"}));
        $str .= ")";
    }
return $str;
}

sub add_hotlist_count
{
my ($bufpointer, %hotlist) = @_;

return "" if ( weechat::config_boolean( $options{"hotlist_counter"} ) eq 0 or ($weechat_version < 0x00030500));   # off
my $col_number_char = weechat::color(weechat::config_color( $options{"color_number_char"}) );
my $str = " ".$col_number_char."(";

# 0 = low level
if (defined $hotlist{$bufpointer."_count_00"})
{
    my $bg = weechat::config_color( $options{"color_hotlist_low_bg"} );
    my $color = weechat::config_color( $options{"color_hotlist_low_fg"} );
    $str .= weechat::color($bg).
            weechat::color($color).
            $hotlist{$bufpointer."_count_00"} if ($hotlist{$bufpointer."_count_00"} ne "0");
}

# 1 = message
if (defined $hotlist{$bufpointer."_count_01"})
{
    my $bg = weechat::config_color( $options{"color_hotlist_message_bg"} );
    my $color = weechat::config_color( $options{"color_hotlist_message_fg"} );
    if ($str =~ /[0-9]$/)
    {
        $str .= ",".
                weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_01"} if ($hotlist{$bufpointer."_count_01"} ne "0");
    }else
    {
        $str .= weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_01"} if ($hotlist{$bufpointer."_count_01"} ne "0");
    }
}
# 2 = private
if (defined $hotlist{$bufpointer."_count_02"})
{
    my $bg = weechat::config_color( $options{"color_hotlist_private_bg"} );
    my $color = weechat::config_color( $options{"color_hotlist_private_fg"} );
    if ($str =~ /[0-9]$/)
    {
        $str .= ",".
                weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_02"} if ($hotlist{$bufpointer."_count_02"} ne "0");
    }else
    {
        $str .= weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_02"} if ($hotlist{$bufpointer."_count_02"} ne "0");
    }
}
# 3 = highlight
if (defined $hotlist{$bufpointer."_count_03"})
{
    my $bg = weechat::config_color( $options{"color_hotlist_highlight_bg"} );
    my $color = weechat::config_color( $options{"color_hotlist_highlight_fg"} );
    if ($str =~ /[0-9]$/)
    {
        $str .= ",".
                weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_03"} if ($hotlist{$bufpointer."_count_03"} ne "0");
    }else
    {
        $str .= weechat::color($bg).
                weechat::color($color).
                $hotlist{$bufpointer."_count_03"} if ($hotlist{$bufpointer."_count_03"} ne "0");
    }
}
$str .= $col_number_char. ")";

$str = "" if (weechat::string_remove_color($str, "") eq " ()");         # remove color and check for buffer with no messages
return $str;
}

sub buffers_signal_buffer
{
    my ($data, $signal, $signal_data) = @_;

    # check for buffer_switch and set or remove detach time
    if ($weechat_version >= 0x00030800)
    {
        if ($signal eq "buffer_switch")
        {
            my $pointer = weechat::hdata_get_list (weechat::hdata_get("buffer"), "gui_buffer_last_displayed"); # get switched buffer
            my $current_time = time();
            if ( weechat::buffer_get_string($pointer, "localvar_type") eq "channel")
            {
                $buffers_timer{$pointer} = $current_time;
            }
            else
            {
                delete $buffers_timer{$pointer};
            }
        }
        if ($signal eq "buffer_opened")
        {
            my $current_time = time();
            $buffers_timer{$signal_data} = $current_time;
        }
        if ($signal eq "buffer_closing")
        {
            delete $buffers_timer{$signal_data};
        }
    }
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_hotlist
{
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}


sub buffers_signal_config_whitelist
{
    @whitelist_buffers = ();
    @whitelist_buffers = split( /,/, weechat::config_string( $options{"look_whitelist_buffers"} ) );
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_config_immune_detach_buffers
{
    @immune_detach_buffers = ();
    @immune_detach_buffers = split( /,/, weechat::config_string( $options{"immune_detach_buffers"} ) );
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_config_detach_buffer_immediately
{
    @detach_buffer_immediately = ();
    @detach_buffer_immediately = split( /,/, weechat::config_string( $options{"detach_buffer_immediately"} ) );
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_config
{
    weechat::bar_item_update($SCRIPT_NAME);
    return weechat::WEECHAT_RC_OK;
}

# called when mouse click occured in buffers item: this callback returns buffer
# hash according to line of item where click occured
sub buffers_focus_buffers
{
    my %info = %{$_[1]};
    my $item_line = int($info{"_bar_item_line"});
    undef my $hash;
    if (($info{"_bar_item_name"} eq $SCRIPT_NAME) && ($item_line >= 0) && ($item_line <= $#buffers_focus))
    {
        $hash = $buffers_focus[$item_line];
    }
    else
    {
        $hash = {};
        my $hash_focus = $buffers_focus[0];
        foreach my $key (keys %$hash_focus)
        {
            $hash->{$key} = "?";
        }
    }
    return $hash;
}

# called when a mouse action is done on buffers item, to execute action
# possible actions: jump to a buffer or move buffer in list (drag & drop of buffer)
sub buffers_hsignal_mouse
{
    my ($data, $signal, %hash) = ($_[0], $_[1], %{$_[2]});
    my $current_buffer = weechat::buffer_get_integer(weechat::current_buffer(), "number"); # get current buffer number

    if ( $hash{"_key"} eq "button1" )
    {
        # left mouse button
        if ($hash{"number"} eq $hash{"number2"})
        {
            if ( weechat::config_boolean($options{"jump_prev_next_visited_buffer"}) )
            {
                if ( $current_buffer eq $hash{"number"} )
                {
                    weechat::command("", "/input jump_previously_visited_buffer");
                }
                else
                {
                    weechat::command("", "/buffer ".$hash{"full_name"});
                }
            }
            else
            {
                weechat::command("", "/buffer ".$hash{"full_name"});
            }
        }
        else
        {
            move_buffer(%hash) if (weechat::config_boolean($options{"mouse_move_buffer"}));
        }
    }
    elsif ( ($hash{"_key"} eq "button2") && (weechat::config_boolean($options{"jump_prev_next_visited_buffer"})) )
    {
        # right mouse button
        if ( $current_buffer eq $hash{"number2"} )
        {
            weechat::command("", "/input jump_next_visited_buffer");
        }
    }
    elsif ( $hash{"_key"} =~ /wheelup$/ )
    {
        # wheel up
        if (weechat::config_boolean($options{"mouse_wheel"}))
        {
            weechat::command("", "/buffer -1");
        }
    }
    elsif ( $hash{"_key"} =~ /wheeldown$/ )
    {
        # wheel down
        if (weechat::config_boolean($options{"mouse_wheel"}))
        {
            weechat::command("", "/buffer +1");
        }
    }
    else
    {
        my $infolist = weechat::infolist_get("hook", "", "command,menu");
        my $has_menu_command = weechat::infolist_next($infolist);
        weechat::infolist_free($infolist);

        if ( $has_menu_command && $hash{"_key"} =~ /button2/ )
        {
            if ($hash{"number"} eq $hash{"number2"})
            {
                weechat::command($hash{"pointer"}, "/menu buffer1 $hash{short_name} $hash{number}");
            }
            else
            {
                weechat::command($hash{"pointer"}, "/menu buffer2 $hash{short_name}/$hash{short_name2} $hash{number} $hash{number2}")
            }
        }
        else
        {
            move_buffer(%hash) if (weechat::config_boolean($options{"mouse_move_buffer"}));
        }
    }
}

sub move_buffer
{
  my %hash = @_;
  my $number2 = $hash{"number2"};
  if ($number2 eq "?")
  {
      # if number 2 is not known (end of gesture outside buffers list), then set it
      # according to mouse gesture
      $number2 = "1";
      if (($hash{"_key"} =~ /gesture-right/) || ($hash{"_key"} =~ /gesture-down/))
      {
          $number2 = "999999";
          if ($weechat_version >= 0x00030600)
          {
              my $hdata_buffer = weechat::hdata_get("buffer");
              my $last_gui_buffer = weechat::hdata_get_list($hdata_buffer, "last_gui_buffer");
              if ($last_gui_buffer)
              {
                  $number2 = weechat::hdata_integer($hdata_buffer, $last_gui_buffer, "number") + 1;
              }
          }
      }
  }
  my $ptrbuf = weechat::current_buffer();
  weechat::command($hash{"pointer"}, "/buffer move ".$number2);
}

sub check_immune_detached_buffers
{
    my ($buffername) = @_;
    foreach ( @immune_detach_buffers ){
        my $immune_buffer = weechat::string_mask_to_regex($_);
        if ($buffername =~ /^$immune_buffer$/i)
        {
            return 1;
        }
    }
    return 0;
}

sub check_detach_buffer_immediately
{
    my ($buffername) = @_;
    foreach ( @detach_buffer_immediately ){
        my $detach_buffer = weechat::string_mask_to_regex($_);
        if ($buffername =~ /^$detach_buffer$/i)
        {
            return 1;
        }
    }
    return 0;
}

sub shutdown_cb
{
    weechat::command("", "/bar hide " . $SCRIPT_NAME) if ( weechat::config_boolean($options{"toggle_bar"}) eq 1 );
    return weechat::WEECHAT_RC_OK
}

sub check_bar_item
{
    my $item = 0;
    my $infolist = weechat::infolist_get("bar", "", "");
    while (weechat::infolist_next($infolist))
    {
        my $bar_items = weechat::infolist_string($infolist, "items");
        if (index($bar_items, $SCRIPT_NAME) != -1)
        {
            my $name = weechat::infolist_string($infolist, "name");
            if ($name ne $SCRIPT_NAME)
            {
                $item = 1;
                last;
            }
        }
    }
    weechat::infolist_free($infolist);
    return $item;
}
