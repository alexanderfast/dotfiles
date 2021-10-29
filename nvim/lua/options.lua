vim.o.expandtab = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.mouse = 'nicr'
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.termguicolors = true

--vim.o.colorscheme = 'nord'
vim.cmd('colorscheme nord')

-- set in init for now
vim.wo.number = true
vim.wo.relativenumber = true

require'fuzzy'.setup {
  width = 60,
  height = 40,
  blacklist = {
    "vendor"
  },
  border = 'yes', -- can be 'no' as well
  prompt = '> ',
}
