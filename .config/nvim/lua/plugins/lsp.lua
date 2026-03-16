return {
  -- Configure lsp and tree sitter,
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              -- LazyVim often already uses SchemaStore.nvim;
              -- disabling built-in schemaStore avoids duplicate catalogs.
              -- schemaStore = { enable = false, url = "" },

              -- Add your own schema mappings (these override/augment)
              -- schemas = {
              --   -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci*.{yml,yaml}",
              --   -- ["https://json.schemastore.org/gitlab-ci.json"] = {
              --   --   ".gitlab-ci.yml",
              --   --   ".gitlab-ci.yaml",
              --   -- },
              --   ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
              --   ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
              --   ["https://json.schemastore.org/docker-compose.json"] = "*docker-compose*.{yml,yaml}",
              -- },

              -- Example: Kubernetes manifests (pick one that matches your files)
              -- ["https://json.schemastore.org/kubernetes.json"] = "*.k8s.{yml,yaml}",

              customTags = {
                "!reference sequence",
                -- "!reference scalar",
                -- "!reference mapping",
              },
            },

            validate = true,
            completion = true,
            hover = true,
          },
        },
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

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- { import = "lazyvim.plugins.extras.lang.typescript" },

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
        "helm",
        "go",
      },
    },
  },

  -- -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- -- would overwrite `ensure_installed` with the new value.
  -- -- If you'd rather extend the default config, use the code below instead:
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     -- add tsx and treesitter
  --     vim.list_extend(opts.ensure_installed, {
  --       "tsx",
  --       "typescript",
  --     })
  --   end,
  -- },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  -- { import = "lazyvim.plugins.extras.lang.json" },

  -- NOTE: mason does not work with NixOS
  -- {
  --   "mason-org/mason.nvim",
  --   enabled = false,
  -- },

  -- {
  --   "mason-org/mason-lspconfig.nvim",
  --   enabled = false,
  -- },

  { "nvim-neotest/nvim-nio" },
}
