#!/bin/bash
NOW_PLAYING=$(osascript <<EOF
set spotify_state to false
set itunes_state to false
...
on is_app_running(app_name)
tell application "System Events" to (name of processes) contains app_name
end is_app_running
EOF)

echo $NOW_PLAYING
