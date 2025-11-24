return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED for Harpoon v2
      harpoon:setup()

      -- keymaps
      local map = vim.keymap.set
      map("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Add file" })
      map("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: Toggle menu" })

      -- direct file navigation (1–5)
      map("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon to file 1" })
      map("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon to file 2" })
      map("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon to file 3" })
      map("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon to file 4" })
      map("n", "<leader>5", function()
        harpoon:list():select(5)
      end, { desc = "Harpoon to file 5" })

      -- cycling
      map("n", "<C-e>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon prev" })
      map("n", "<C-n>", function()
        harpoon:list():next()
      end, { desc = "Harpoon next" })
    end,
  },
}
