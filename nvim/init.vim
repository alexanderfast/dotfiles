" plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'itchyny/lightline.vim'
Plug 'hashivim/vim-terraform'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()

" options
set expandtab
set showmatch
set ignorecase
set hlsearch
set smarttab
set shiftwidth=4
set tabstop=4
set mouse=v                 " mouse only in visual mode
set incsearch
set autoindent
set termguicolors
set number
set relativenumber
set backspace=indent,eol    " dont backspace across lines
set nowrap
set linebreak
set noswapfile
set nowritebackup
set foldmethod=syntax
set splitbelow
set splitright

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

" show nerdtree when started with no args
function! StartUp()
    if !argc()
        NERDTree
    end
endfunction
autocmd vimenter * call StartUp()

" keybinds
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap confe :e $MYVIMRC<CR>
nnoremap confr :source $MYVIMRC<CR>

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType ruby map <buffer> <F9> :w<CR>:exec '!rake' shellescape(@%, 1)<CR>
autocmd FileType ruby imap <buffer> <F9> <esc>:w<CR>:exec '!rake' shellescape(@%, 1)<CR>
