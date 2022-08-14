local awful = require "awful"

local unplugged_icons = { '', '', '', '', '', '', '', '', '', '', '' }
local charging_icons = {'', '', '', '', '', '', ''}

local makeNormalizeFunction = function(orig_min, orig_max, new_min, new_max)
    return function(value)
        return (new_max - new_min) / (orig_max - orig_min) * (value - orig_max) + new_max
    end
end

local makeIconFunction = function (icons, range_min, range_max)
    if range_min == nil then range_min = 0 end
    if range_max == nil then range_max = 100 end
    local numberOfIcons = #icons
    local normalize = makeNormalizeFunction(range_min, range_max, 1, numberOfIcons)
    return function(value)
        return icons[math.ceil(normalize(value))]
    end
end

local getUnpluggedIcon = function(value)
    return makeIconFunction(unplugged_icons)(value)
end
local getChargingIcon = function(value)
    return makeIconFunction(charging_icons)(value)
end

return awful.widget.watch([[sh -c "acpi | grep -i 'Battery 0'"]], 30, function(widget, stdout)
    local pattern = 'Battery 0: (%a+), (%d+)%%, .*'
    local _, _, status, percentage = string.find(stdout, pattern)
    local iconFunction = getUnpluggedIcon 
    if status == 'Charging' then iconFunction = getChargingIcon end
    local icon = iconFunction(percentage)
	widget:set_text(string.format("%s%s%%", icon, percentage))
end)

