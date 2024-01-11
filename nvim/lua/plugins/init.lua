-- TODO remove this file
return {
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- after = 'nvim-treesitter',
  },

  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("todo-comments").setup { }
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup { }
    end
  },

  -- use 'nvie/vim-flake8'

  -- use 'freddiehaddad/feline.nvim'           -- Fancier statusline
  { 'tpope/vim-sleuth' },                    -- Detect tabstop and shiftwidth automatically
  { 'voldikss/vim-floaterm' },               -- Easy access terminal


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
  { 'EdenEast/nightfox.nvim', priority = 1000 },

  -- { "xiyaowong/transparent.nvim" },

  -- second part of tmux plugin for seamless navigation
  -- { "christoomey/vim-tmux-navigator" },

  -- "williamboman/mason.nvim",

  -- Useful status updates for LSP
  -- { 'j-hui/fidget.nvim', tag = 'legacy' }
}

