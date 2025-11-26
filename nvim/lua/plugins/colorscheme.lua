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
        hl.ColorColumn = { bg = colors.bg_dark }
      end,
    },
  },

  -- Vscode theme
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    config = function()
      -- Set theme style: "dark", "light", or "highcontrast"
      vim.g.vscode_style = "dark"
    end,
  },

  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- load immediately
    config = function()
      require("kanagawa").setup({
        compile = true, -- enable compiling for faster startup
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { italic = false },

        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true,
        specialException = true,
        dimInactive = false, -- dim inactive windows
        transparent = false, -- set true for no background
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none", -- remove background of line number gutter
              },
            },
          },
        },
      })
    end,
  },
}
