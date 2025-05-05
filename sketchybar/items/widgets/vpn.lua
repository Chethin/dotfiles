local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Create a minimal VPN item
local vpn = sbar.add("item", "vpn", {
  position = "right",
  padding_right = -2,
  icon = {
    string = app_icons["NordVPN"],
    font = "sketchybar-app-font:Regular:16.0",
    color = colors.green,
  },
})

local vpn_bracket = sbar.add("bracket", "widgets.vpn.bracket", {
  vpn.name
}, {
  background = { color = colors.bg1 },
  popup = { align = "center" }
})

sbar.add("item", "widgets.vpn.padding", {
  position = "right",
  width = settings.group_paddings
})

-- Check VPN connection and update the item
local function check_vpn()
  sbar.exec([[scutil --nc list | grep 'Connected' | sed -E 's/.*"(.+)".*/\1/']], function(output)
    output = (output or ""):gsub("^%s*(.-)%s*$", "%1") -- trim whitespace

    if output ~= "" then
      vpn:set({
        icon = { color = colors.green },
      })
    else
      vpn:set({
        icon = { color = colors.red },
      })
    end
    sbar.delay(10, check_vpn)
  end)
end

-- -- Run on launch and then every 10 seconds
check_vpn()

-- Subscribe to VPN connection changes
vpn:subscribe("vpn_update", function(env)
  check_vpn()
end)

-- open nord vpn when mouse pressed
vpn:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'NordVPN'")
end)