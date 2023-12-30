-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Basic keybinds for better navigation
vim.keymap.set('n', '<leader>z', 'ZZ<CR>')
vim.keymap.set('n', '<leader>w', ':wa<CR>')
vim.keymap.set('n', '<leader>Q', ':wqa!<CR>')
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>')
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>')
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>')
vim.keymap.set('n', '<leader>tq', ':tabclose<CR>')
vim.keymap.set('n', '<leader>tQ', ':tabonly<CR>')
--vim.keymap.set({ 'n', 'v', 'i' }, 'jk', '<ESC>')
vim.keymap.set('n', '<leader>p', 'viw"_dP') -- replace inside word
vim.keymap.set('n', '<leader>f', ':Format<CR>')
vim.keymap.set('n', '<leader><leader>s', ':source $MYVIMRC<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- NeoTree keybinds
vim.keymap.set('n', '<leader>nt', ':Neotree toggle<CR>')
vim.keymap.set('n', '<leader>nb', ':Neotree buffers<CR>')
vim.keymap.set('n', '<leader>nl', ':Neotree float<CR>')
vim.keymap.set('n', '<leader>nf', ':Neotree focus<CR>')

-- Neotest
vim.keymap.set('n', '<leader>tp', ':lua require("neotest").output_panel.toggle()<CR>')
vim.keymap.set('n', '<leader>ts', ':lua require("neotest").summary.toggle()<CR>')
vim.keymap.set('n', '<leader>trf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>')
vim.keymap.set('n', '<leader>trn', ':lua require("neotest").run.run()<CR>')

-- FloaTerm configuration
vim.keymap.set('n', "<leader>t", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>")
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- Quickfix
vim.keymap.set("n", "<leader>co", ":copen<CR>")
vim.keymap.set("n", "<leader>cl", ":ccl<CR>")
vim.keymap.set("n", "<leader>cw", ":cw<CR>")
vim.keymap.set("n", "<leader>cn", ":cn<CR>")
vim.keymap.set("n", "<leader>cp", ":cp<CR>")
vim.keymap.set("n", "<C-S-j>cn", ":cn<CR>")
vim.keymap.set("n", "<C-S-k>cp", ":cp<CR>")
vim.keymap.set("n", "<leader>c<CR>", ":.cc<CR>")

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xn", function() require("trouble").next({skip_groups = true, jump = true}) end)
vim.keymap.set("n", "<leader>xp", function() require("trouble").previous({skip_groups = true, jump = true}) end)
-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
--   { silent = true, noremap = true }
-- )

-- Dap
vim.keymap.set('n', '<leader>dtm', ':lua require("dap-python").test_method()<CR>')
vim.keymap.set('n', '<leader>dtc', ':lua require("dap-python").test_class()<CR>')
vim.keymap.set('n', '<leader>dts', '<ESC>:lua require("dap-python").debug_selection()<CR>')

vim.keymap.set('n', '<F6>', function() require('dap').continue() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('', '<Leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>duc', function() require("dapui").close() end)
vim.keymap.set('n', '<leader>duo', function() require("dapui").open() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
