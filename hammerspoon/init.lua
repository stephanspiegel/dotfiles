hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "r", function()
    hs.reload()
end)

yabai = require("yabai")
caps2esc = require("caps2esc")

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
