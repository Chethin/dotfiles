return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, colors)
        -- brighter current line number
        hl.LineNr = { fg = colors.blue, bold = true }

        -- brighter relative numbers above/below
        hl.LineNrAbove = { fg = colors.fg }
        hl.LineNrBelow = { fg = colors.fg }
      end,
    },
  },
}
