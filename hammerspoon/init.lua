hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "r", function()
    hs.reload()
end)

local caps2esc = require("caps2esc")

-- Close all visible notifications in Notification Center.
hs.hotkey.bind({"ctrl", "cmd"}, "n", function()
  hs.task
    .new("/usr/bin/osascript", nil, {
      "-l",
      "JavaScript",
      os.getenv("HOME") .. "/.hammerspoon/close_notifications.js",
    })
    :start()
end)

local function toggleMute()
  local teams = hs.application.find("Teams")
  if not (teams == nil) then
    hs.printf('teams: %s', teams)
        hs.eventtap.keyStroke({"cmd","shift"}, "m", 0, teams)
  end
end

local function toggleAerospace(toggleOp)
    hs.task
      .new("/opt/homebrew/bin/aerospace", nil, {
        "enable",
        toggleOp,
      })
      :start()
    hs.notify.new({title="Presentation Mode", informativeText="Toggled "..toggleOp}):send()
end

local function presentationMode(toggleOp)
  if toggleOp == "on" then
    hs.application.launchOrFocus("DeskPad")
  else
    hs.application.find("DeskPad"):kill()
  end
    hs.notify.new({title="Presentation Mode", informativeText="Toggled "..toggleOp}):send()
  -- toggleAerospace(toggleOp)
end


hs.hotkey.bind({"ctrl"}, "home", toggleMute)

-- hs.hotkey.bind({"alt"}, "[", function() presentationMode("on") end)
-- hs.hotkey.bind({"alt"}, "]", function() presentationMode("off") end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  local appName = hs.application.frontmostApplication():name()
  print(appName)
end)
