local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local mod = require'bindings.mod'
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ mod.super }, "?", hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ mod.super }, "Left", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ mod.super }, "Right", awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ mod.super }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    awful.key({ mod.super }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ mod.super }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ mod.super, mod.shift }, "j", function () awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ mod.super, mod.shift }, "k", function () awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ mod.super, mod.ctrl }, "j", function () awful.screen.focus_relative(1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ mod.super, mod.ctrl }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ mod.super }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    awful.key({ mod.super }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ mod.super, mod.shift }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ mod.super, mod.ctrl }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ mod.super, mod.shift }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    awful.key({ mod.super }, "l", function () awful.tag.incmwfact(0.05) end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ mod.super }, "h",function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ mod.super, mod.shift }, "h", function () awful.tag.incnmaster(1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ mod.super, mod.shift }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ mod.super, mod.ctrl }, "h", function () awful.tag.incncol( 1, nil, true) end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ mod.super, mod.ctrl }, "l", function () awful.tag.incncol(-1, nil, true) end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ mod.super }, "space", function () awful.layout.inc(1) end,
        {description = "select next", group = "layout"}),
    awful.key({ mod.super, mod.shift }, "space", function () awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}),

    awful.key({ mod.super, mod.ctrl }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().promptBox:run() end,
        {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().promptBox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
        {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey }, "s", function() awful.spawn("escrotum -Cs") end,
        {description = "take a screenshot", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ mod.super }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ mod.super, mod.shift }, "c", function (c) c:kill() end,
        {description = "close", group = "client"}),
    awful.key({ mod.super, mod.ctrl }, "space", awful.client.floating.toggle ,
        {description = "toggle floating", group = "client"}),
    awful.key({ mod.super, mod.ctrl }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    awful.key({ mod.super }, "o", function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}),
    awful.key({ mod.super }, "t", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),
    awful.key({ mod.super }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ mod.super }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ mod.super, mod.ctrl }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ mod.super, mod.shift }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ mod.super, mod.ctrl }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ mod.super, mod.shift }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ mod.super, mod.ctrl , mod.shift }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}
