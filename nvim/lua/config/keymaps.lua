-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", {})

vim.keymap.set("n", "<leader>z", "ZZ<CR>")
vim.keymap.set("n", "<leader>q", ":wqa!<CR>")
vim.keymap.set("n", "<leader>p", 'viw"_dP') -- replace inside word

vim.keymap.set("n", "<leader>i", ":vsp<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>u", ":sp<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>n", ":noh<CR>", { desc = "No highlight" })

vim.keymap.set("n", "<leader>ml", ":diffget LO<CR>", { desc = "Merge diffget local" })
vim.keymap.set("n", "<leader>mb", ":diffget BA<CR>", { desc = "Merge diffget base" })
vim.keymap.set("n", "<leader>mr", ":diffget RE<CR>", { desc = "Merge diffget remote" })

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<leader>t", lazyterm, { desc = "Terminal (root dir)" })

vim.cmd([[
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]
]])
