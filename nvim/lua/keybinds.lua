function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- keybinds
map("n", "<leader>n", ":NERDTreeToggle<CR>")
map("n", "<leader>ce", ":e $MYVIMRC<CR>")
map("n", "<leader>cr", ":source $MYVIMRC<CR>")
map("n", "<leader>z", "ZZ<CR>")
map("n", "<leader>h", ":noh<CR>")
map("n", "<leader>w", ":wa<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>Q", ":wqa!<CR>")
map("n", "<leader>ss", ":vsp<CR>")
map("n", "<leader>si", ":split<CR>")
map("n", "<leader>t", ":tabnew<CR>")

map("n", "<leader>co", ":copen<CR>")
map("n", "<leader>ccl", ":ccl<CR>")
--map("n", "<C-j>", ":cnext<CR>")
--map("n", "<C-k>", ":cprevious<CR>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- delete current file
map("n", "<leader>DD", ":call delete(expand('%')) | bdelete!<CR>")

-- keybinds git
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gd", ":Git diff<CR>")
map("n", "<leader>gc", ":Git commit -av<CR>")
map("n", "<leader>gp", ":Git push<CR>")
map("n", "<leader>gl", ":Git pull --rebase<CR>")

-- keybinds telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fr", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>fm", "<cmd>Telescope marks<cr>")
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>")
map("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>")
map("n", "<leader>fgbc", "<cmd>Telescope git_bcommits<cr>")
map("n", "<leader>fgbr", "<cmd>Telescope git_branches<cr>")
map("n", "<leader>fgs", "<cmd>Telescope git_status<cr>")

-- lsp
map("n", "<leader>le", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>lsd", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
map("n", "<leader>lsw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
