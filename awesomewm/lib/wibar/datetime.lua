local wibox = require("wibox")
return wibox.widget {
    {
        widget = wibox.widget.textclock("%a-%FT%H:%M")
    },
    widget = wibox.container.background,
}
