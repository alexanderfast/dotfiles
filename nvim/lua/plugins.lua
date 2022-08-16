return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'joshdick/onedark.vim'
    use 'itchyny/lightline.vim'
    use 'neovim/nvim-lspconfig'
    use { 'preservim/nerdtree', { opt = True, cmd = 'NERDTreeToggle' }}
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
end)
