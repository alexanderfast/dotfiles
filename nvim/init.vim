lua require('plugins')
lua require('set')
lua require('keybinds')
lua require('treesitterconf')
lua require('telescopeconf')


" status bar
lua require('lualine').setup()

" terraform
let g:terraform_align=1

" restore cursor to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'

" ripgrep
let g:rg_highlight = 'true'
let g:rg_command = 'rg --vimgrep -S'

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType ruby map <buffer> <F9> :w<CR>:exec '!rake' shellescape(@%, 1)<CR>
autocmd FileType ruby imap <buffer> <F9> <esc>:w<CR>:exec '!rake' shellescape(@%, 1)<CR>

lua << EOF
require("lspconfig").pylsp.setup{}
require("lspconfig").solargraph.setup{}
require('lspconfig').kotlin_language_server.setup({
    cmd = { "kotlin-language-server" };
    filetypes = { "kotlin" };
    on_attach = custom_lsp_attach
})
EOF

set completeopt-=preview

" use omni completion provided by lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
