require("ibl").setup()

-- slightly fade the indent char
vim.api.nvim_set_hl(0, "IblIndent", { link = "comment lua" })
