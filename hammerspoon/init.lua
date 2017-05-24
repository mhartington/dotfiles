local modalKey = {"alt"}
local resizeMappings = {
  h={x=0, y=0, w=0.5, h=1},
  j={x=0, y=0.5, w=1, h=0.5},
  k={x=0, y=0, w=1, h=0.5},
  l={x=0.5, y=0, w=0.5, h=1},
  m={x=0, y=0, w=1, h=1},
  u={x=0, y=0, w=0.33, h=1},
  i={x=0.33, y=0, w=0.33, h=1},
  o={x=0.66, y=0, w=0.33, h=1},

  b={x=0, y=0, w=0.75, h=1},
  n={x=0.75, y=0, w=0.25, h=1},
}

for key in pairs(resizeMappings) do
  hs.hotkey.bind(modalKey, key, function()
    local win = hs.window.focusedWindow()
    if win then win:moveToUnit(resizeMappings[key]) end
  end)
end

hs.hotkey.bind(modalKey, "r", function()
  hs.reload()
end)

local focusKeys = {
  s='Safari',
  -- a='Atom',
  -- w='Mail',
  c='Google Chrome',
  -- b='Google Chrome Canary',
  d='Slack',
  f='iTerm',
  -- f='Hyper',
  e='Simulator',
  t='Messages',
  -- v="Visual Studio Code"
}

for key in pairs(focusKeys) do
  hs.hotkey.bind(modalKey, key, function()
    hs.application.launchOrFocus(focusKeys[key])
  end)
end

hs.hotkey.bind({"alt","shift"}, "l", function()
  send_window_next_monitor()
end)

hs.hotkey.bind({"alt", "shift"}, "h", function()
  send_window_prev_monitor()
end)

function send_window_next_monitor()
  hs.alert.show("Next Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():next()
  win:moveToScreen(nextScreen)
end


function send_window_prev_monitor()
  hs.alert.show("Prev Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():previous()
  win:moveToScreen(nextScreen)
end
