-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  { "sindrets/diffview.nvim" },

  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("colorizer").setup({})
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      -- level = 3,
      render = "minimal",
      stages = "fade",
    },
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>-",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "[-] Fuzzily search in current buffer]",
      },
      -- {
      --   "<leader>sb",
      --   function()
      --     require("telescope.builtin").buffers()
      --   end,
      --   desc = "[S]earch [B]uffers",
      -- },
      -- vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
      -- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- {
      --   "<leader>se",
      --   function()
      --     require("telescope.builtin").registers()
      --   end,
      --   desc = "[S]earch r[E]gisters",
      -- },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "[S]earch [F]iles",
      },
      -- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      -- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      {
        "<leader>sj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "[S]earch [J]umplist",
      },
      -- vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
      {
        "<leader>sl",
        function()
          require("telescope.builtin").loclist()
        end,
        desc = "[S]earch [L]oclist",
      },
      -- vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
      -- vim.keymap.set('n', '<leader>sM', require('telescope.builtin').man_pages, { desc = '[S]earch [M]an pages' })
      -- vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles, { desc = '[S]earch [o]ld files' })
      {
        "<leader>sp",
        function()
          require("telescope.builtin").pickers()
        end,
        desc = "[S]earch [P]ickers",
      },
      -- {
      --   "<leader>sr",
      --   function()
      --     require("telescope.builtin").resume()
      --   end,
      --   desc = "Resume",
      -- },
      -- {
      --   "<leader>sR",
      --   function()
      --     -- require("telescope.builtin").resume()
      --   end,
      --   desc = "Unbind",
      -- },
      {
        "<leader>sq",
        function()
          require("telescope.builtin").quickfix()
        end,
        desc = "[S]earch [Q]uickfix",
      },
      {
        "<leader>su",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "[S]earch Telescope B[u]iltins",
      },
      -- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      --
      -- vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Search [G]it [B]ranches' })
      -- vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Search [G]it [C]ommits' })
      -- vim.keymap.set('n', '<leader>gt', require('telescope.builtin').git_status, { desc = 'Search [G]it S[t]atus' })
      --
      -- vim.keymap.set('n', '<leader>st', ":TodoTelescope<CR>", { desc = '[S]earch [T]odo' })
      --vim.keymap.set('n', '<leader>sta', require('telescope.builtin').tags, { desc = '[S]earch [Ta]gs' })
    },
    -- change some options
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
        },
        winblend = 0,
      },
      pickers = {
        live_grep = {
          additional_args = function()
            -- search in hidden files
            return { "--hidden" }
          end,
        },
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    enabled = false, -- TODO: re-enable once the keybind clash is fixed
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sR", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
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

  -- -- the opts function can also be used to change the default opts:
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, "😄")
  --   end,
  -- },

  -- -- or you can return new options to override all the defaults
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       --[[add your custom lualine config here]]
  --     }
  --   end,
  -- },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

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
    -- opts will be merged with the parent spec
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
    },
  },

  -- sister plugin to tmux navigator
  { "christoomey/vim-tmux-navigator" }
}
