" plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'arcticicestudio/nord-vim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'itchyny/lightline.vim'
Plug 'hashivim/vim-terraform'
call plug#end()

" options
set expandtab
set showmatch
set ignorecase
set hlsearch
set smarttab
set shiftwidth=4
set tabstop=4
set mouse=v
set incsearch
set autoindent
set termguicolors
set number
set relativenumber

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

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
nnoremap <C-n> :NERDTreeToggle<CR>

" keybinds
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType ruby map <buffer> <F9> :w<CR>:exec '!rake' shellescape(@%, 1)<CR>
autocmd FileType ruby imap <buffer> <F9> <esc>:w<CR>:exec '!rake' shellescape(@%, 1)<CR>
