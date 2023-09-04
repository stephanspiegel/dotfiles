-- ╒══════════════════════════════════════════════════════════╕
--                    Plugin Specifications
-- ╘══════════════════════════════════════════════════════════╛
local plugin_specifications = {
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  { "psliwka/vim-smoothie" }, -- smooth scrolling
  { "tpope/vim-surround" }, -- surround with quotes, brackets, etc.
  { "fcpg/vim-spotlightify" }, -- Highlighted search results, improved
  { "tpope/vim-abolish" }, -- Search for, substitute, and abbreviate multiple variants of a word
  {
    "tpope/vim-unimpaired", -- Handy pairs of keymappings
    config = function()
      -- Make `[q` etc scroll to the middle
      -- need to explicitly pass `{silent=true}` because we don't want `{noremap=true}` from the defaults
      require("stephanspiegel.maputil").nmap_all({
        { "[q", "<Plug>(unimpaired-cprevious)zz", { silent = true } },
        { "]q", "<Plug>(unimpaired-cnext)zz", { silent = true } },
        { "[Q", "<Plug>(unimpaired-cfirst)zz", { silent = true } },
        { "]Q", "<Plug>(unimpaired-clast)zz", { silent = true } },
        { "[l", "<Plug>(unimpaired-lprevious)zz", { silent = true } },
        { "]l", "<Plug>(unimpaired-lnext)zz", { silent = true } },
        { "[L", "<Plug>(unimpaired-lfirst)zz", { silent = true } },
        { "]L", "<Plug>(unimpaired-llast)zz", { silent = true } },
      })
    end,
  },
  { "tpope/vim-sleuth" }, -- automatically set tabstop
  {
    "windwp/nvim-autopairs",
    config = function()
      require("stephanspiegel.pluginconfigs.autopairs")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "info",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = false,
        auto_session_suppress_dirs = nil,
      })
    end,
  },
  {
    "sudormrfbin/cheatsheet.nvim", -- cheat sheets with telescope UI
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "jremmen/vim-ripgrep" },
  { "xiyaowong/nvim-transparent" },
  { "chrisbra/Recover.vim" }, -- Add option `(C)ompare` when swapfile found
  { "phaazon/mind.nvim",      -- tree-based note taking system
    config = function()
      require("mind").setup()
    end
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Navigation                        │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("stephanspiegel.pluginconfigs.nvim-tree")
    end,
  },
  { "ThePrimeagen/harpoon" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.projects")
    end,
  },
  {
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
      vim.g.vista_fzf_preview = { "right:50%" }
    end,
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                            UI                            │
  -- ╰──────────────────────────────────────────────────────────╯
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
  { "kyazdani42/nvim-web-devicons" },
  {
    "rcarriga/nvim-notify", -- notification popups
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("stephanspiegel.pluginconfigs.notify")
    end,
  },
  {
    "meznaric/conmenu", -- context menu
    dependencies = {
      "ThePrimeagen/git-worktree.nvim",
    },
    config = function()
      require("stephanspiegel.pluginconfigs.conmenu")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("stephanspiegel.pluginconfigs.lualine")
    end,
  },
  {
    "startup-nvim/startup.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("stephanspiegel.pluginconfigs.startup")
    end,
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                 Languages and filetypes                  │
  -- ╰──────────────────────────────────────────────────────────╯
  { "kmonad/kmonad-vim" },
  { "chrisbra/csv.vim" },
  { "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Kraftwerk                         │
-- ╰──────────────────────────────────────────────────────────╯

  {
    dir =  "~/Projects/vim/kraftwerk.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.kraftwerk")
    end
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Completion                        │
  -- ╰──────────────────────────────────────────────────────────╯
  { "hrsh7th/nvim-cmp" }, -- The completion plugin
  { "hrsh7th/cmp-buffer" }, -- buffer completions
  { "hrsh7th/cmp-path" }, -- path completions
  { "hrsh7th/cmp-cmdline" }, -- cmdline completions
  { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
  { "lukas-reineke/cmp-rg" }, -- ripgrep everything
  { "hrsh7th/cmp-nvim-lsp" }, -- lsp completions
  { "hrsh7th/cmp-nvim-lua" }, -- source for neovim Lua API
  -- snippets
  { "L3MON4D3/LuaSnip" }, -- snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           LSP                            │
  -- ╰──────────────────────────────────────────────────────────╯
  { "williamboman/mason.nvim",  -- package manager for LSP servers, DAP servers, linters, and formatters
    config = function()
      require("mason").setup()
    end,
  },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  { "neovim/nvim-lspconfig",
    config = function()
      require("stephanspiegel.lsp")
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("stephanspiegel.pluginconfigs.trouble")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim", -- use LSP API with linters that aren't strictly speaking LSPs
    config = function()
      require("stephanspiegel.pluginconfigs.null-ls")
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("stephanspiegel.pluginconfigs.nvim-dap")
    end,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    }
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    config = function()
      local dap = require"dap"
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }
      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
    end,
    dependencies = { "mfussenegger/nvim-dap" }
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Telescope                         │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "fzf"
    },
    config = function()
      require("stephanspiegel.telescope")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", 
    build = "make",
    name = "fzf"
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Treesitter                        │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("stephanspiegel.treesitter")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "p00f/nvim-ts-rainbow" }, -- highlight brackets in matching colors
  { "nvim-treesitter/playground",
    build = ":TSInstall query"
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           git                            │
  -- ╰──────────────────────────────────────────────────────────╯
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.gitsigns")
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.diffview")
    end,
  },
  { 'rickhowe/spotdiff.vim' }, -- show diffs per selection
  { 'rickhowe/diffchar.vim' }, -- show diff character by character
  {
    "ThePrimeagen/git-worktree.nvim", -- wrapper for git-worktrees
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("git_worktree")
      vim.cmd([[ command! WorktreeList lua require('telescope').extensions.git_worktree.git_worktrees() ]])
      vim.cmd([[ command! WorktreeCreate lua require('telescope').extensions.git_worktree.create_git_worktree() ]])
    end,
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                          Ledger                          │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "ledger/vim-ledger",
    ft = "ledger",
    config = function()
      require("stephanspiegel.pluginconfigs.ledger")
    end,
  },
  { "rcaputo/vim-ledger_x" },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         Diagrams                         │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "jbyuki/venn.nvim", -- Diagrams in vim
    config = function()
      require("stephanspiegel.pluginconfigs.venn")
    end,
  },
  {
    "willchao612/vim-diagon", -- Simple Unicode or ASCII diagrams
    config = function()
      vim.g.diagon_use_echo = 1 --- Use echo instead of replacing original text directly
    end,
  },
  { "LudoPinelli/comment-box.nvim" }, -- Draw boxes around comments
}

-- ╒══════════════════════════════════════════════════════════╕
--                     Theme Specifications
-- ╘══════════════════════════════════════════════════════════╛
local colorscheme_specifications = {
  { "folke/tokyonight.nvim" },
  { "junegunn/seoul256.vim" },
  { "mhartington/oceanic-next" },
  { "morhetz/gruvbox" },
  { "rafamadriz/neon" },
  { "rakr/vim-one" },
  { "rakr/vim-two-firewatch" },
  { "rockerBOO/boo-colorscheme-nvim" },
  { "sainnhe/edge" },
  { "sainnhe/everforest" },
  { "sainnhe/forest-night" },
  { "sainnhe/gruvbox-material" },
  { "sainnhe/sonokai" },
  { "savq/melange" },
  { "smallwat3r/vim-hashpunk-sw" },
  { "theniceboy/nvim-deus" },
  { "xstrex/FireCode.vim" },
  { "ayu-theme/ayu-vim" },
  { "bluz71/vim-moonfly-colors" },
  { "mbbill/desertEx" },
  { "shaunsingh/oxocarbon.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "arcticicestudio/nord-vim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({ colorscheme = "neon_latte" })
    end,
  },
  { "embark-theme/vim",
    name = "embark"
  },
  { "eddyekofo94/gruvbox-flat.nvim" },
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        dark_variant = "moon",
      })
    end,
  },
  { "https://gitlab.com/protesilaos/tempus-themes-vim" },
}

-- ├──────────────────────────────────────────────────────────┤

local fn = vim.fn
local cmd = vim.cmd

-- Automatically install lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

vim.list_extend(plugin_specifications, colorscheme_specifications)
local config_overrides = {}
return  lazy.setup(plugin_specifications, config_overrides)
