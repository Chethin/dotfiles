return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  -- JSX/TSX syntax highlight & treesitter context
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "tsx", "typescript", "json", "html", "css" })
    end,
  },

  -- Tailwind / className completion
  { "luckasRanarison/tailwind-tools.nvim", opts = {} },

  -- Surround, comment, autopairs
  { "kylechui/nvim-surround", opts = {} },
  { "windwp/nvim-autopairs", opts = {} },

  -- Visual hints for component props (optional)
  { "dmmulroy/ts-error-translator.nvim", opts = {} },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      per_filetype = {
        html = {
          enable_close = false,
        },
      },
    },
  },
}
