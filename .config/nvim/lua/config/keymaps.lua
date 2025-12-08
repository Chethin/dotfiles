local map = vim.keymap.set

-- better fast scroll
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- better scroll
map({ "n", "x" }, "<D-j>", "10jzz", { noremap = true, silent = true })
map({ "n", "x" }, "<D-k>", "10kzz", { noremap = true, silent = true })

-- Save and return to normal mode
map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- surround selection
map("x", "(", "c(<ESC>pa)")
map("x", "'", "c'<ESC>pa'")
map("x", '"', 'c"<ESC>pa"')
map("x", "[", "c[<ESC>pa]")
map("x", "{", "c{<ESC>pa}")

-- Move lines vertically
map("n", "<a-j>", ":m .+1<CR>==", { noremap = true, silent = true })
map("n", "<a-k>", ":m .-2<CR>==", { noremap = true, silent = true })
map("v", "<a-j>", ":m '>+1<CR>==gv=gv", { noremap = true, silent = true })
map("v", "<a-k>", ":m '<-2<CR>==gv=gv", { noremap = true, silent = true })
