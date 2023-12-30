-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true
vim.o.cursorline = false

-- Enable mouse mode
vim.o.mouse = 'v'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Default open place for new splits
vim.o.splitbelow = true
vim.o.splitright = true

-- No swapfile
vim.o.swapfile = false

-- Use scrolloff to keep cursor closer to middle for context
vim.o.scrolloff = 10
vim.o.sidescrolloff = 15
vim.o.sidescroll = 1
