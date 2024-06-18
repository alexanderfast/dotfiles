-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", {})

vim.keymap.set("n", "<leader>z", "ZZ<CR>")
vim.keymap.set("n", "<leader>Q", ":wqa!<CR>")
vim.keymap.set("n", "<leader>p", 'viw"_dP') -- replace inside word

vim.keymap.set("n", "<leader>i", ":vsp<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>u", ":sp<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>n", ":noh<CR>", { desc = "No highlight" })

vim.keymap.set("n", "<leader>ml", ":diffget LO<CR>", { desc = "Merge diffget local" })
vim.keymap.set("n", "<leader>mb", ":diffget BA<CR>", { desc = "Merge diffget base" })
vim.keymap.set("n", "<leader>mr", ":diffget RE<CR>", { desc = "Merge diffget remote" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<leader>t", lazyterm, { desc = "Terminal (root dir)" })

-- vim.keymap.set("n", "ö", "[")
-- vim.keymap.set("n", "ä", "]")

vim.cmd([[
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]
]])
