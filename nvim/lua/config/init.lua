local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- base lazyvim
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
    { import = "plugins" },
  },
  defaults = {
    autocmds = true,
    keybinds = true, -- disable if there are too many keybind conflicts
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  news = {
    lazyvim = true,
    neovim = true,
  },
  -- diagnostics = {
  --   Error = " ",
  --   Warn = " ",
  --   Hint = " ",
  --   Info = " ",
  -- },
  -- git = {
  --   added = " ",
  --   modified = " ",
  --   removed = " ",
  -- },
  install = { colorscheme = { "nightfox", "tokyonight", "habamax", "catpuccin" } },
  checker = {
    enabled = false, -- disable automatic check for plugin updates
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
