-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "folke/flash.nvim",
    enabled = false,
  },

  { "sindrets/diffview.nvim" },

  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = false, -- "Name" codes like Blue or blue
        },
      })
    end,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- neotree file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["u"] = "open_split",
          ["i"] = "open_vsplit",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          always_show_by_pattern = { -- uses glob style patterns
            --".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          bind_to_cwd = false,
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      },
    },
  },

  -- conform for formatting code
  {
    "stevearc/conform.nvim",
    --dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    --keys = {
    --  {
    --    "<leader>cF",
    --    function()
    --      require("conform").format({ formatters = { "injected" } })
    --    end,
    --    mode = { "n", "v" },
    --    desc = "Format Injected Langs",
    --  },
    --},
    opts = {
      lsp_fallback = true,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "autopep8", "isort" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettierd", "prettier" },
        json = { "prettiertw4" },
        nix = { "nixfmt" },
        terraform = { "terraform_fmt" },
        go = { "goimports", "gofmt" },
        markdown = { "markdownlint" },
        -- Default formatter
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        prettiertw4 = {
          command = "prettier",
          args = { "--tab-width", "4", "$FILENAME" },
        },
      },
    },
  },

  {
    "CRAG666/code_runner.nvim",
    -- config = true,
    cmd = "RunCode",
    keys = {
      {
        "<leader>r",
        function()
          require("code_runner").run_code()
        end,
        desc = "Run code",
      },
    },
    opts = {
      mode = "term",
      focus = false,
      before_run_filetype = function()
        vim.cmd.write()
      end,
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        go = {
          "cd $dir &&",
          "go run $fileName",
        },
        -- c = function(...)
        --   c_base = {
        --     "cd $dir &&",
        --     "gcc $fileName -o",
        --     "/tmp/$fileNameWithoutExt",
        --   }
        --   local c_exec = {
        --     "&& /tmp/$fileNameWithoutExt &&",
        --     "rm /tmp/$fileNameWithoutExt",
        --   }
        --   vim.ui.input({ prompt = "Add more args:" }, function(input)
        --     c_base[4] = input
        --     vim.print(vim.tbl_extend("force", c_base, c_exec))
        --     require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
        --   end)
        -- end,
      },
    },
  },

  -- open line in browser
  {
    "almo7aya/openingh.nvim",
  },

  -- disables auto popup of blink
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          auto_show = false,
        },
        ghost_text = {
          enabled = false,
        },
      },
    },
  },

  {
    "mpeterv/hererocks",
    enabled = false,
  },

  -- {
  --   "mfussenegger/nvim-dap-python",
  --   enabled = false,
  -- },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },
}
