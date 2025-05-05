local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Create a minimal VPN item
local messages = sbar.add("item", "messages", {
  position = "right",
  icon = {
    string = app_icons["Messages"] or "💬",
    font = "sketchybar-app-font:Regular:16.0",
    color = colors.green,
  },
  label = {
    drawing = true,
    color = colors.red,
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 11.0,
    },
  },
  drawing = true,
})

local messages_bracket = sbar.add("bracket", "widgets.messages.bracket", {
  messages.name
}, {
  background = { color = colors.bg1 },
  drawing = false,
})

sbar.add("item", "widgets.messages.padding", {
  position = "right",
  width = settings.group_paddings,
  drawing = false,
})

-- open nord vpn when mouse pressed
messages:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Messages'")
end)

-- Unread iMessage count query (from chat.db)
local function update_message_notifications()
  local query = [[
    sqlite3 ~/Library/Messages/chat.db \
    "SELECT COUNT(guid) FROM message WHERE NOT(is_read) AND NOT(is_from_me) AND text != '';" 2>/dev/null
  ]]
  sbar.exec(query, function(output)
    local count = tonumber(output)
    if count and count > 0 then
      messages:set({
        label = { string = tostring(count), color = colors.red },
        icon = { color = colors.green },
        drawing = true,
      })
      sbar.set("widgets.messages.bracket", { drawing = true })
      sbar.set("widgets.messages.padding", { drawing = true })
    else
      messages:set({
        drawing = false,
      })
      sbar.set("widgets.messages.bracket", { drawing = false })
      sbar.set("widgets.messages.padding", { drawing = false })
    end
    sbar.delay(10, update_message_notifications)
  end)
end


update_message_notifications()

