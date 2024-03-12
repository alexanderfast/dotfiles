return {
  -- Configure lsp and tree sitter,
  -- disable mason hooks in lspconfig and mason itself, as it doesnt work in NixOS
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {
          mason = false,
        },
        lua_ls = {
          mason = false,
        },
        pyright = {
          mason = false,
          settings = {
            singlefilesupport = true
          }
        },
      },
      -- -- you can do any additional lsp server setup here
      -- -- return true if you don't want this server to be setup with lspconfig
      -- ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      -- setup = {
      --   -- example to setup with typescript.nvim
      --   tsserver = function(_, opts)
      --     require("typescript").setup({ server = opts })
      --     return true
      --   end,
      --   -- Specify * to use this function as a fallback for any server
      --   -- ["*"] = function(server, opts) end,
      -- },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "terraform",
        "hcl",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    enabled = false,
    --opts = {
    --  ensure_installed = {
    --    "stylua",
    --    "shellcheck",
    --    "shfmt",
    --    "flake8",
    --  },
    --},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    enabled = false,
  },
}
