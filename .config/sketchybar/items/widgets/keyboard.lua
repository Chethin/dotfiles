local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local keyboard = sbar.add("item", "widgets.keyboard", {
  position = "right",
  icon = { drawing = false },
  label = { font = { family = settings.font.numbers } },
  update_freq = 1,
})

local function update_keyboard()
  sbar.exec("defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID", function(layout_id)
    layout_id = layout_id:lower()
    if layout_id:find("colemak") then
      keyboard:set({
        label = { string = "Colemak", color = colors.blue },
      })
    elseif layout_id:find("australian") or layout_id:find("qwerty") then
      keyboard:set({
        label = { string = "Qwerty", color = colors.green },
      })
    else
      keyboard:set({
        label = { string = "Unknown", color = colors.grey },
      })
    end
  end)
end

keyboard:subscribe("routine", update_keyboard)

sbar.add("bracket", "widgets.keyboard.bracket", { keyboard.name }, {
  background = { color = colors.bg1 }
})

sbar.add("item", "widgets.keyboard.padding", {
  position = "right",
  width = settings.group_paddings
})

update_keyboard()
