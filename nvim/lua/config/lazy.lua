local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " "

local plugins = {
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require 'nvim-web-devicons'.setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        },
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true,
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
        -- globally enable "strict" selection of icons - icon will be looked up in
        -- different tables, first by filename, and if not found by extension; this
        -- prevents cases when file doesn't have any extension but still gets some icon
        -- because its name happened to match some extension (default to false)
        strict = true,
        -- same as `override` but specifically for overrides by filename
        -- takes effect when `strict` is true
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
        },
        -- same as `override` but specifically for overrides by extension
        -- takes effect when `strict` is true
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
        },
      }
    end
  },

  -- Useful status updates for LSP
  -- { 'j-hui/fidget.nvim', tag = 'legacy' }

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',

      -- Auto configures rust
      'simrat39/rust-tools.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip',
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- after = 'nvim-treesitter',
  },

  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("todo-comments").setup {
      }
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  },

  -- use 'nvie/vim-flake8'

  -- Git related plugins
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'lewis6991/gitsigns.nvim' },

  -- use 'freddiehaddad/feline.nvim'           -- Fancier statusline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Add indentation guides even on blank lines
  { 'numToStr/Comment.nvim' },               -- "gc" to comment visual regions/lines
  { 'tpope/vim-sleuth' },                    -- Detect tabstop and shiftwidth automatically
  { 'voldikss/vim-floaterm' },               -- Easy access terminal

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('telescope').setup {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = 'top'
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              --["<C-h>"] = "which_key"
              ["<C-s>"] = "select_vertical",
              ["<C-x>"] = "select_horizontal"
            },
            n = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              --["<C-h>"] = "which_key"
              ["<C-s>"] = "select_vertical",
              ["<C-x>"] = "select_horizontal"
            }
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        },
      }
    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

  -- Lua formatter with stylua, assumes cargo is installed
  -- { 'ckipp01/stylua-nvim', build = 'cargo install stylua' },

  -- Show signatures
  { 'ray-x/lsp_signature.nvim' },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },

  -- Folder/tree view
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "BufReadPre",
    module = { "dap" },
    -- wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      { "leoluz/nvim-dap-go",                module = "dap-go" },
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = function()
      -- local dap_install = require "dap-install"
      -- dap_install.setup {
      --   installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
      -- }

      local dap_breakpoint = {
        error = {
          text = "🔴",
          texthl = "LspDiagnosticsSignError",
          linehl = "",
          numhl = "",
        },
        rejected = {
          text = "",
          texthl = "LspDiagnosticsSignHint",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = "⭕",
          texthl = "LspDiagnosticsSignInformation",
          linehl = "DiagnosticUnderlineInfo",
          numhl = "LspDiagnosticsSignInformation",
        },
      }

      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup {} -- use default
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        --dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        --dapui.close()
      end

      require("dap-python").setup("python", {})
      require('dap-python').test_runner = 'pytest'
    end,
  },

  -- Unit testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      "vim-test/vim-test",
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
            runner = "pytest",
          },
        },
      }
    end,
  },

  -- { "catppuccin/nvim", as = "catppuccin" },
  -- { "shaunsingh/nord.nvim" },
  -- { "AlexvZyl/nordic.nvim" },
  -- { 'rmehri01/onenord.nvim' },
  -- { 'cocopon/iceberg.vim' },
  { 'EdenEast/nightfox.nvim' },

  -- { "xiyaowong/transparent.nvim" },

  -- second part of tmux plugin for seamless navigation
  -- { "christoomey/vim-tmux-navigator" },
}

require("lazy").setup(plugins)
