local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.numbers },
			string = i,
			padding_left = 15,
			padding_right = 8,
			color = colors.white,
			highlight_color = colors.blue,
		},
		label = {
			padding_right = 20,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		background = {
			color = colors.bg1,
			border_width = 1,
			height = 26,
			border_color = colors.black,
		},
		popup = { background = { border_width = 5, border_color = colors.black } },
	})

	spaces[i] = space

	-- Single item bracket for space items to achieve double border on highlight
	local space_bracket = sbar.add("bracket", { space.name }, {
		background = {
			color = colors.transparent,
			border_color = colors.bg2,
			height = 28,
			border_width = 2,
		},
	})

	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = settings.group_paddings,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	-- Track selected state so hover can restore correctly
	local is_selected = false

	space:subscribe("space_change", function(env)
		is_selected = (env.SELECTED == "true")
		space:set({
			icon = { highlight = is_selected },
			label = { highlight = is_selected },
			background = { border_color = is_selected and colors.black or colors.bg2 },
		})
		space_bracket:set({
			background = { border_color = is_selected and colors.grey or colors.bg2 },
		})
	end)

	-- Hover in: subtle fill + brighter border + raise label
	space:subscribe("mouse.entered", function(_)
		sbar.animate("tanh", 0, function()
			space:set({
				background = {
					color = colors.hover,
				},
			})
		end)
	end)

	-- Hover out: restore to selected/unselected look
	space:subscribe("mouse.exited", function(_)
		-- remove the popup if any
		space:set({ popup = { drawing = false } })
		-- animate hover removal
		sbar.animate("tanh", 0, function()
			space:set({
				background = {
					color = colors.bg1,
					border_color = is_selected and colors.black or colors.bg2,
				},
				label = {
					color = is_selected and colors.white or colors.grey,
				},
			})
			space_bracket:set({
				background = { border_color = is_selected and colors.grey or colors.bg2 },
			})
		end)
	end)

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			sbar.exec("yabai -m space --focus " .. env.SID)
		end
	end)
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

local spaces_indicator = sbar.add("item", {
	padding_left = 0,
	padding_right = 0,
	icon = {
		padding_left = 8,
		padding_right = 10,
		color = colors.grey,
		string = icons.switch.on,
	},
	label = {
		drawing = false,
	},
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, _ in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		icon_line = icon_line .. icon
	end

	if no_app then
		icon_line = " —"
	end
	sbar.animate("tanh", 10, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(_)
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
	})
end)

spaces_indicator:subscribe("mouse.entered", function(_)
	sbar.animate("tanh", 3, function()
		spaces_indicator:set({
			background = {
				color = colors.hover,
			},
		})
	end)
end)

spaces_indicator:subscribe("mouse.exited", function(_)
	sbar.animate("tanh", 3, function()
		spaces_indicator:set({
			background = {
				color = colors.transparent,
			},
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(_)
	sbar.trigger("swap_menus_and_spaces")
end)
