require "nvchad.mappings"

local function save_and_notify()
  vim.cmd('w!')
  local filename = vim.fn.expand('%:t')
  vim.notify(filename .. " saved!", vim.log.levels.INFO)
end

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>qq", ":qa!<CR>", { desc = "Quit Neovim " })
map("n", "<leader>ss", ":SCNvimStart<CR>", { desc = "Start SClang" })
map("n", "<leader>sl", ":SCNvimStatusLine<CR>", { desc = "SC Statusline" })
map("n", "<leader>gp", ":!git add . ;git commit -m 'push';git push<CR>", { desc = "Git Add/Comm/Push" })

map("n", "<leader>pr", ":w<CR>:!python3 %<CR>", { desc = "Run Python File" })
-- Tab control
map("n", "<A-1>", ":tabprevious<CR>", opts)
map("n", "<A-2>", ":tabnext<CR>", opts)
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
map({'n', 'i', 'v'}, '<c-s>', save_and_notify, { desc = "Save file and notify" })

-- Jump to next "(" at beginning of a line
map("n", "<A-]>", "/^(<CR>", { noremap = true })

-- Jump to previous "(" at beginning of a line
map("n", "<A-[>", "?^(<CR>", { noremap = true })

map("n", "<A-k>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-j>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- Reload .lua
vim.keymap.set("n", "<leader>rr", function()
  -- Reload the init.lua file
  vim.cmd "luafile $MYVIMRC"
  print "Lua reloaded!!"
end, { desc = "Reload lua file" })

local unpack = unpack or table.unpack
-- <leader>gp : Git add . && commit -m "Update" && push
map("n", "<leader>gp", function()
  vim.cmd("silent !git add .")
  vim.cmd("silent !git commit -m 'update'")
  vim.cmd("silent !git push")
  print("✓ Git pushed: Update")
end, { desc = "Git add, commit ('Update'), and push", unpack(opts) })
-- test

-- <leader>gP : Git pull
map("n", "<leader>gP", function()
  vim.cmd("silent !git pull")
  print("✓ Git pulled")
end, { desc = "Git pull", unpack(opts) })
