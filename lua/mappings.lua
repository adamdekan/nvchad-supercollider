require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>qq", ":q!<CR>", { desc = "Quit Neovim "})
map("n", "<leader>ss", ":SCNvimStart<CR>", { desc = "Start SClang"})
map("n", "<leader>sl", ":SCNvimStatusLine<CR>", { desc = "SC Statusline"})
map("n", "<leader>gp", ":!git add . ;git commit -m 'push';git push<CR>", { desc = "Git Add/Comm/Push"})

-- Scroll and center
map("n", "<C-d>", "<C-d>zz", opts)
map("v", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("v", "<C-u>", "<C-u>zz", opts)

-- Center cursor after search
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)

-- Cursor movement in insert mode
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-l>", "<Right>", opts)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Jump to next "(" at beginning of a line
map('n', '<A-]>', "/^(<CR>", { noremap = true })

-- Jump to previous "(" at beginning of a line
map('n', '<A-[>', "?^(<CR>", { noremap = true })

map("n", "<A-k>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-j>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- Reload init.lua
vim.keymap.set('n', '<leader>rr', function()
  -- Reload the init.lua file
  vim.cmd('luafile $MYVIMRC')
  print("init.lua reloaded")
end, { desc = "Reload init.lua" })
