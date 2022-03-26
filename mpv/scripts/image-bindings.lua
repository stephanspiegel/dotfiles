
local options = {
    gesture_click = 'playlist-next force',
    gesture_up = 'no-osd set video-zoom 0',
    gesture_right = 'no-osd cycle-values video-unscaled yes no; no-osd set video-zoom 0',
    gesture_down = 'script-message playlist-view-open',
    gesture_left = 'playlist-prev',
}

require 'mp.options'.read_options(options)

mp.register_script_message('rm-file', function()
    os.remove(mp.get_property('path'))
    mp.command('playlist-remove current')
end)

mp.register_script_message('pan-image', function (axis, amount)
    local dims = mp.get_property_native('osd-dimensions')
    local dimension = axis == 'x' and dims.w - dims.ml - dims.mr or dims.h - dims.mt - dims.mb
    local osd_dimension = axis == 'x' and dims.w or dims.h
    -- 1 video-align shifts the OSD by (dimension - osd_dimension) / 2 pixels
    -- so the equation to find how much video-align to add to offset the OSD by osd_dimension is
    -- x/1 = osd_dimension / ((dimension - osd_dimension) / 2)
    if dimension > osd_dimension then
        mp.commandv('add', 'video-align-' .. axis, amount * 2 * osd_dimension / (dimension - osd_dimension))
    end
end)

mp.register_script_message('cursor-centric-zoom', function (amount)
    local mouse_pos = mp.get_property_native('mouse-pos')
    local dims = mp.get_property_native('osd-dimensions')
    local width = (dims.w - dims.ml - dims.mr) * 2^amount
    local height = (dims.h - dims.mt - dims.mb) * 2^amount
    local command = 'no-osd add video-zoom ' .. amount .. ';'

    if width > dims.w then
        local old_cursor_ml = dims.ml - mouse_pos.x
        local cursor_ml = old_cursor_ml * 2^amount
        local ml = cursor_ml + mouse_pos.x
        -- from video/out/aspect.c:src_dst_split_scaling() we know that:
        -- ml = (osd-width - width) * (video-align-x + 1) / 2
        -- so video-align-x is:
        local video_align_x = 2 * ml / (dims.w - width) - 1
        command = command .. 'no-osd set video-align-x ' .. math.min(1, math.max(video_align_x, -1)) .. ';'
    end

    if height > dims.h then
        local mt = (dims.mt - mouse_pos.y) * 2^amount + mouse_pos.y
        local video_align_y = 2 * mt / (dims.h - height) - 1
        command = command .. 'no-osd set video-align-y ' .. math.min(1, math.max(video_align_y, -1))
    end

    mp.command(command)
end)

local is_intial_callback
local function undo_lavfi_complex()
    if is_intial_callback then
        is_intial_callback = false
        return
    end
    mp.set_property('lavfi-complex', '')
    mp.set_property('vid', 1)
    mp.unobserve_property(undo_lavfi_complex)
end

mp.register_script_message('double-page-mode', function()
    if mp.get_property_native('lavfi-complex') ~= '' then
        undo_lavfi_complex()
        return
    end

    local previous = mp.get_property('playlist/' .. mp.get_property('playlist-pos') - 1 .. '/filename')
    if not previous then
        local error = 'double-page-mode only works if there is a previous playlist entry.'
        mp.msg.error(error)
        mp.osd_message(error)
        return
    end
    mp.commandv('video-add', previous)
    local track_list = mp.get_property_native('track-list')
    if track_list[1]['demux-w'] ~= track_list[2]['demux-w'] or track_list[1]['demux-h'] ~= track_list[2]['demux-h'] then
        mp.set_property('vid', 1)
        mp.command('video-remove 2')
        local error = 'The 2 images must have the same dimensions.'
        mp.msg.error(error)
        mp.osd_message(error)
        return
    end
    mp.set_property('lavfi-complex', '[vid1] [vid2] hstack [vo]')
    is_intial_callback = true
    mp.observe_property('playlist-pos', 'native', undo_lavfi_complex)
end)
