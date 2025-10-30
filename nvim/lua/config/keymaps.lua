-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- Normal mode: make Ctrl+u perform Ctrl+u then recenter (zz)
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

map("n", "<D-j>", "10jzz", { noremap = true, silent = true })
map("n", "<D-k>", "10kzz", { noremap = true, silent = true })

map("n", "<D-a>", "ggVG", { noremap = true, silent = true })

vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
