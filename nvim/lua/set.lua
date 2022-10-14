local set = vim.opt

set.expandtab = true          -- convert tab to space
set.showmatch = true          -- show matching
set.ignorecase = true         -- case insensitive
set.hlsearch = true           -- highlight search
set.smarttab = true
set.shiftwidth = 4            -- width for autoindent
set.tabstop = 4               -- number of columns in a tab
set.mouse = v                 -- mouse only in visual mode
set.incsearch = true          -- incremental search
set.autoindent = true
set.termguicolors = true
set.number = true             -- show line numbers
set.relativenumber = true     -- show relative line numbers
set.backspace = indent,eol    -- dont backspace across lines
set.linebreak = true
--set.nowritebackup = true
--set.foldmethod = syntax
--set.foldlevelstart = 20
set.splitbelow = true
set.splitright = true
set.cursorline = true         -- highlight current line
--set.cursorlineopt = number    -- highlight current line through number
set.swapfile = false

vim.cmd "colorscheme onedark"
