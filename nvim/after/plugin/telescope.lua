-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>-', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[-] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sa', require('telescope.builtin').autocommands, { desc = '[S]earch [A]utocommands' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>se', require('telescope.builtin').registers, { desc = '[S]earch r[E]gisters' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').loclist, { desc = '[S]earch [L]oclist' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sM', require('telescope.builtin').man_pages, { desc = '[S]earch [M]an pages' })
vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles, { desc = '[S]earch [o]ld files' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').pickers, { desc = '[S]earch [P]ickers' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = '[S]earch [Q]uickfix' })
vim.keymap.set('n', '<leader>su', require('telescope.builtin').builtin, { desc = '[S]earch Telescope B[u]iltins' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Search [G]it [B]ranches' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Search [G]it [C]ommits' })
vim.keymap.set('n', '<leader>gt', require('telescope.builtin').git_status, { desc = 'Search [G]it S[t]atus' })

vim.keymap.set('n', '<leader>st', ":TodoTelescope<CR>", { desc = '[S]earch [T]odo' })
--vim.keymap.set('n', '<leader>sta', require('telescope.builtin').tags, { desc = '[S]earch [Ta]gs' })
