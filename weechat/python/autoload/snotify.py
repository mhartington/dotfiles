# Copyright (c) 2010 by Stephan Huebner <s.huebnerfun01@gmx.org>
#
# Intended use:
#
# play a soundfile when a message comes in (for choosable buffers)
#
# TODO: implement playing a soundfile when a highlight occurs
# TODO: (possibly) show the number of unread private messages and
#       highlights in status bar
# TODO: Find out, why sometimes "w.hook_process" doesn't seem to
#       start (or at least no sound is being played)
# TODO: (possibly) Change app-choosing to some predefined options (like
#       mplayer, vlc or ogg123, etc...)
# TODO: Make the whole script more Python-like (if I find out how...)
# TODO: Make the script not beep on message from yourself
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
# History:
#	2010-10-17: version 0.1: initial release
#
#  2010-10-17: version 0.1.1:
#     * change: If a buffer + sound is added and psound is empty, then
#                psound is set to given sound
#     * fix: bugs in "on"- and "off"-functions
#     * fix: "on"- and "off"-statusses were not used
#  2010-11-15: Version 0.1.3
#		* change: No sound is played anymore on messages from yourself.
#		* fix: a new sound for an entry already in the list wasn't set.
#		* change: Replaced "weechat.hook_process" with Pythons' "subprocess.Popen"

import subprocess as s
from os.path import expanduser

SCR_NAME    = "snotify"
SCR_AUTHOR  = "Stephan Huebner <shuebnerfun01@gmx.org>"
SCR_VERSION = "0.1.3"
SCR_LICENSE = "GPL3"
SCR_DESC    = "Play a soundfile for messages in choosable channels or queries"
SCR_COMMAND = "snotify"

import_ok = True

bfList = []
muted = False

try:
	import weechat as w
except:
	print "Script must be run under weechat. http://www.weechat.org"
	import_ok = False

settings = {
	"player" : "mplayer", # Application used to play a soundfile
	"psound" : "", # Sound that should be played on private messages
	"hsound" : "", # Sound that should be played on highlights
	"buffers" : ""
}

def errMsg(myMsg):
	alert("ERR: " + myMsg)
	return

def fn_hook_process(data, command, rc, stdout, stderr):
	alert(stderr)
	return w.WEECHAT_RC_OK
	
def fn_privmsg(data, bufferp, time, tags, display, is_hilight, prefix, msg):
	global bfList
	global settings
	servername = (w.buffer_get_string(bufferp, "name").split("."))[0]
	ownNick = w.info_get("irc_nick", servername)
	mySound = ""
	if not muted and prefix != ownNick:
		if settings["player"] == "":
			errMsg("'Player' isn't set!")
		else:
			for lEntry in bfList:
				if lEntry["buffer"] == w.buffer_get_string(bufferp, "name"):
					# we found a buffer of that name
					if lEntry["status"] == "on":
						if lEntry["sound"] == "":
							if settings["psound"] == "":
								errMsg("No sound defined! Please set either the " +
										 "regular 'psound'-option or the 'sound'-" +
										 "option for this buffer.")
							else:
								mySound = settings["psound"]
						else:
							mySound = lEntry["sound"]
						s.Popen([settings["player"], expanduser(mySound)],
								stderr=s.STDOUT, stdout=s.PIPE)
					break
	return w.WEECHAT_RC_OK

def fn_command(data, buffer, args):
	global bfList
	global muted
	args = args.split()
	myStatus = "on"
	mySound = ""
	myBuffer = ""
	if len(args)>0:
		try: # set a valid buffer and soundfile
			myArg = args[1]
			myBuffer = w.buffer_search("irc", myArg)
			if myBuffer == "":
				# no buffer with that name, so so assume it's the soundfile
				mySound = myArg
				myBuffer = w.current_buffer()
			else: # we have a buffer, now look for a soundfile
				try:
					mySound = args[2]
				except:
					mySound = ""
		except: # no further arguments, so set valid buffer + sound
			myBuffer = w.current_buffer()
			mySound = settings["psound"]
		myBuffer = w.buffer_get_string(myBuffer, "name")
		if args[0] == "test":
			if settings["psound"] == "":
				errMsg("No sound defined! Please set 'psound'-option!")
			else:
				s.Popen([settings["player"], expanduser(mySound)],
						  stderr=s.STDOUT, stdout=s.PIPE)
		elif args[0] == "list":
			for lEntry in bfList:
				alert("BUFFER: " + lEntry["buffer"] + " | " +
					  "STATUS: " + lEntry["status"] + " | " +
					  "SOUND:  " + lEntry["sound"])
			if len(bfList) == 0:
				errMsg("No buffers configured!")
		elif args[0] == "muteall":
			muted = True
			alert("All buffers are muted")
		elif args[0] == "demuteall":
			muted = False
			alert("Sounds will be played")
		elif args[0] == "add":
			for listIndex in range(len(bfList)):
				if bfList[listIndex]["buffer"] == myBuffer:
					bfList.pop(listIndex)
					break
			bfList += [{"buffer":myBuffer,"status":myStatus,"sound":mySound}]
			if settings["psound"] == "":
				settings["psound"] = mySound
				w.config_set_plugin("psound", mySound)
			w.config_set_plugin("buffers", fn_createBufferString())
		elif args[0] == "remove":
			for listIndex in range(len(bfList)):
				if bfList[listIndex]["buffer"] == myBuffer:
					bfList.pop(listIndex)
					break
			w.config_set_plugin("buffers", fn_createBufferString())
		elif args[0] == "on":
			for listIndex in range(len(bfList)):
				if bfList[listIndex]["buffer"] == myBuffer:
					bfList[listIndex]["status"] = "on"
					w.config_set_plugin("buffers", fn_createBufferString())
					break
		elif args[0] == "off":
			for lIndex in range(len(bfList)):
				if bfList[lIndex]["buffer"] == myBuffer:
					bfList[lIndex]["status"] = "off"
					w.config_set_plugin("buffers", fn_createBufferString())
					break
	return w.WEECHAT_RC_OK

def fn_createBufferString():
	global bfList
	myString = ""
	for lEntry in bfList:
		myString += "{'" + lEntry["buffer"] + "','" + lEntry["status"]
		myString += "','" + lEntry["sound"] + "'}"
	return myString

def alert(myString):
	w.prnt("", myString)
	return

def fn_configchange(data, option, value):
	global settings
	fields = option.split(".")
	myOption = fields[-1]
	try:
		settings[myOption] = value
		#alert("Option {0} has been changed to {1}".format(myOption,
		#			settings[myOption]))
	except KeyError:
		errMsg("There is no option named %s" %myOption)
	return w.WEECHAT_RC_OK

if __name__ == "__main__" and import_ok:
	if w.register(SCR_NAME, SCR_AUTHOR, SCR_VERSION, SCR_LICENSE,
						SCR_DESC, "", ""):
		# synchronize weechat- and scriptsettings
		for option, default_value in settings.items():
			if not w.config_is_set_plugin(option):
				w.config_set_plugin(option, default_value)
			else:
				settings[option] = w.config_get_plugin(option)
				if option == "buffers":	# need to set buffers seperately
					myBuffers = settings[option][2:-2]
					try:
						myBuffers = myBuffers.split("'}{'")
						for tmp in myBuffers:
							myBuffer, myStatus, mySound = tmp.split("','")
							bfList += [{"buffer":myBuffer,"status":myStatus,
										 "sound":mySound}]
					except:
						myBuffers = ""
		w.hook_print("", "", "", 1, "fn_privmsg", "") # catch prvmsg
		w.hook_config("plugins.var.python." + SCR_NAME + ".*",
							"fn_configchange", "") # catch configchanges
		w.hook_command( # help-text
			SCR_COMMAND, SCR_DESC,
			"[test] | [add] [buffer] [sound[] | [remove] buffer | " +
			"[on] [buffer] | [off] [buffer] | [muteall] | " +
			"[demuteall] | [list]",
			"Attention:" +
"""
* in places where you can enter a buffername, its best to use the 'Tab'-key
  to cycle through available buffers. If no buffer is chosen at all or the
  buffer doesn't exist, the current buffer will be used.
* You are free to choose whatever player you want (by entering its' name. I
  urge you to *not* enter any command that could be dangerous, as the
  command will be executed just as if it were entered on the commandline.
  The suggestion for common players would be 'mplayer', 'vlc' or 'ogg123';
  without the quotes of course).
  
Available options are:
- player:  The application used to play a soundfile
- psound:  The soundfile that should be played
- buffers: The saved buffers (it's best to not edit that setting directly.
  Rather choose one of the above mentioned commands).
  
Commands:
- test:      Test soundplaying with current settings
- add:       add/edit a buffer. If no sound is chosen, the standard on is being
             used (if one is set)
- remove:    Remove a buffer.
- off:       Turn off sound for buffer
- on:        Turn on sound for buffer
- muteall:   Turn off sounds for all buffers
- demuteall: Turn on sounds for all buffers that were activated before
- list:      List all saved buffers""",
			"|| add %(buffers_names)"
			"|| remove %(buffers_names)"
			"|| on %(buffers_names)"
			"|| off %(buffers_names)"
			"mute"
			"muteall", "fn_command", ""
			)
