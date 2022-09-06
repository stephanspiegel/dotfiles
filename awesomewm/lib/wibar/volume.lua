return (require "awful").widget.watch("pamixer --get-volume-human", 0.1, function(self, stdout)
	local icon = "墳"
	if string.find(stdout, "muted") then
		icon = "婢"
	end
	self:set_text(string.format("%s %s", icon, stdout))
end)
