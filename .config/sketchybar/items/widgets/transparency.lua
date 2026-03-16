local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local transparency = sbar.add("item", "widgets.transparency", {
  position = "right",
  padding_right = -1,
  icon = {
    string = icons.switch.on,
    font = {
      style = settings.font.style_map["Regular"],
      size = 16.0,
    },
    color = colors.blue,
  },
})

local transparency_bracket = sbar.add("bracket", "widgets.transparency.bracket", {
  transparency.name
}, {
  background = { color = colors.bg1 },
})

sbar.add("item", "widgets.transparency.padding", {
  position = "right",
  width = settings.group_paddings
})

-- State file path
local STATE_FILE = os.getenv("HOME") .. "/.config/sketchybar/.transparency_state"

-- Read current state from file
local function get_state()
  local file = io.open(STATE_FILE, "r")
  if file then
    local state = file:read("*all"):gsub("%s+", "")
    file:close()
    return state
  end
  return "on"
end

-- Update widget based on state
local function update_widget(state)
  if state == "on" then
    transparency:set({
      icon = {
        string = icons.switch.on,
        color = colors.blue,
      }
    })
  else
    transparency:set({
      icon = {
        string = icons.switch.off,
        color = colors.red,
      }
    })
  end
end

-- Initialize widget state
update_widget(get_state())

-- Subscribe to transparency changes
transparency:subscribe("transparency_change", function(env)
  local state = env.INFO
  update_widget(state)
end)

-- Toggle transparency on click
transparency:subscribe("mouse.clicked", function(env)
  sbar.exec("$HOME/.config/sketchybar/helpers/toggle_transparency.sh")
end)
