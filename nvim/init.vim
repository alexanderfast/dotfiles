" plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'Yggdroot/indentLine', { 'for': 'yaml' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'nvim-0.6' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

" options
set expandtab               " convert tab to space
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set smarttab
set shiftwidth=4            " width for autoindent
set tabstop=4               " number of columns in a tab
set mouse=v                 " mouse only in visual mode
set incsearch               " incremental search
set autoindent
set termguicolors
set number                  " show line numbers
set relativenumber          " show relative line numbers
set backspace=indent,eol    " dont backspace across lines
set linebreak
set noswapfile              " disable swap file
set nowritebackup
set foldmethod=syntax
set foldlevelstart=20
set splitbelow
set splitright
set cursorline              " highlight current line
set cursorlineopt=number    " highlight current line through number

colorscheme nord

" status bar
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

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

" keybinds
let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>ce :e $MYVIMRC<CR>
nnoremap <leader>cr :source $MYVIMRC<CR>
nnoremap <leader>z ZZ<CR>
nnoremap <leader>h :noh<CR>
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :wqa!<CR>
nnoremap <leader>ss :vsp<CR>
nnoremap <leader>si :split<CR>
nnoremap <leader>t :tabnew<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>ccl :ccl<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>

" keybinds git
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gc :Git commit -av<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull --rebase<CR>

" keybinds telescope
:lua require('telescopeconf')
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgbc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgbr <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType ruby map <buffer> <F9> :w<CR>:exec '!rake' shellescape(@%, 1)<CR>
autocmd FileType ruby imap <buffer> <F9> <esc>:w<CR>:exec '!rake' shellescape(@%, 1)<CR>
