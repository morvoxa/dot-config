local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local net_speed = {}

function net_speed.new(user_config)
	local config = user_config or {}
	local interface = config.interface or "wlan0"
	local timeout = config.timeout or 2
	local font = config.font or "sans bold 9"

	local prev_rx = 0
	local prev_tx = 0

	local text_widget = wibox.widget.textbox()
	text_widget.font = font
	text_widget.align = "center"
	text_widget.valign = "center"

	local android_container = wibox.container.background()
	android_container.bg = "#2a2a2a"
	android_container.fg = "#e3e3e3"
	android_container.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 12)
	end

	local final_widget = wibox.container.margin(android_container, 4, 4, 3, 3)
	android_container:set_widget(wibox.container.margin(text_widget, 10, 10, 2, 2))

	local function format_speed(bytes)
		local speed = bytes / timeout
		if speed > 1048576 then
			return string.format("%.1f M/s", speed / 1048576)
		else
			return string.format("%.0f K/s", speed / 1024)
		end
	end

	local cmd = "awk '/" .. interface .. ":/ {print $2, $10}' /proc/net/dev"

	awful.widget.watch(cmd, timeout, function(w, stdout)
		local rx, tx = stdout:match("(%d+)%s+(%d+)")

		if rx and tx then
			rx = tonumber(rx)
			tx = tonumber(tx)

			if prev_rx > 0 and prev_tx > 0 then
				local down_speed = format_speed(rx - prev_rx)
				local up_speed = format_speed(tx - prev_tx)

				text_widget:set_markup(
					string.format(
						"<span color='#a8dadc'>▲</span> %s  <span color='#f1faee'>▼</span> %s",
						up_speed,
						down_speed
					)
				)
				android_container.bg = "#1a1c1e"
			else
				text_widget:set_text("Connecting...")
			end

			prev_rx = rx
			prev_tx = tx
		else
			text_widget:set_markup("<span color='#ffb4ab'>Offline</span>")
			android_container.bg = "#3c1212"
			prev_rx = 0
			prev_tx = 0
		end
	end, text_widget)

	return final_widget
end

return net_speed
