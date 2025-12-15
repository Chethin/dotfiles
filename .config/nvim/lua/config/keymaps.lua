-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- Normal mode: make Ctrl+u perform Ctrl+u then recenter (zz)
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

map({ "n", "x" }, "<D-j>", "10jzz", { noremap = true, silent = true })
map({ "n", "x" }, "<D-k>", "10kzz", { noremap = true, silent = true })

-- Save and return to normal mode
map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Move lines vertically
map("n", "<a-j>", ":m .+1<CR>==", { noremap = true, silent = true })
map("n", "<a-k>", ":m .-2<CR>==", { noremap = true, silent = true })
map("v", "<a-j>", ":m '>+1<CR>==gv=gv", { noremap = true, silent = true })
map("v", "<a-k>", ":m '<-2<CR>==gv=gv", { noremap = true, silent = true })

-- surround selection
map("x", "(", "c(<ESC>pa)")
map("x", "'", "c'<ESC>pa'")
map("x", '"', 'c"<ESC>pa"')
map("x", "[", "c[<ESC>pa]")
map("x", "{", "c{<ESC>pa}")
