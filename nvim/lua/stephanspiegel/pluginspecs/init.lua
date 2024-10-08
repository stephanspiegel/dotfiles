-- ╒══════════════════════════════════════════════════════════╕
--                    Plugin Specifications
-- ╘══════════════════════════════════════════════════════════╛
local plugin_specifications = {
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  {
    "psliwka/vim-smoothie", -- smooth scrolling
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "tpope/vim-surround", -- surround with quotes, brackets, etc.
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    "fcpg/vim-spotlightify",
    event = { "BufReadPost", "BufNewFile" },
  }, -- Highlighted search results, improved
  { "tpope/vim-abolish" }, -- Search for, substitute, and abbreviate multiple variants of a word
  {
    "tpope/vim-unimpaired", -- Handy pairs of keymappings
    config = function()
      -- Make `[q` etc scroll to the middle
      -- need to explicitly pass `{silent=true}` because we don't want `{noremap=true}` from the defaults
      local unimpaired_opts = { silent = true }
      require("stephanspiegel.maputil").nmap_all({
        { "[q", "<Plug>(unimpaired-cprevious)zz", unimpaired_opts },
        { "]q", "<Plug>(unimpaired-cnext)zz", unimpaired_opts },
        { "[Q", "<Plug>(unimpaired-cfirst)zz", unimpaired_opts },
        { "]Q", "<Plug>(unimpaired-clast)zz", unimpaired_opts },
        { "[l", "<Plug>(unimpaired-lprevious)zz", unimpaired_opts },
        { "]l", "<Plug>(unimpaired-lnext)zz", unimpaired_opts },
        { "[L", "<Plug>(unimpaired-lfirst)zz", unimpaired_opts },
        { "]L", "<Plug>(unimpaired-llast)zz", unimpaired_opts },
      })
    end,
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    "tpope/vim-sleuth", -- automatically set tabstop
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "cohama/lexima.vim", -- auto pair completion
    event = "InsertEnter",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- set commentstrings for apex; for some reason comment.nvim doesn't get it from treesitter
      require('Comment.ft').set('apex', {'//%s', '/*%s*/'})
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_restore = false,
        auto_restore_last_lession = false,
        auto_session_last_session_dir = "",
        enabled = true,
        log_level = "info",
        root_dir = vim.fn.stdpath("data") .. "/sessions/"
      })
    end,
    lazy = false
  },
  {
    "sudormrfbin/cheatsheet.nvim", -- cheat sheets with telescope UI
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "jremmen/vim-ripgrep",
    cmd = { 'Rg' }
  },
  {
    "chrisbra/Recover.vim", -- Add option `(C)ompare` when swapfile found
    event = "SwapExists"
  },
  {
    "phaazon/mind.nvim",      -- tree-based note taking system
    config = function()
      require("mind").setup()
    end
  },

  -- ╭──────────────────────────────────────────────────────────╮
  -- │                            UI                            │
  -- ╰──────────────────────────────────────────────────────────╯
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
  {
    "nvim-tree/nvim-web-devicons",
    name = "devicons"
  },
  {
    "yamatsum/nvim-nonicons",
    requires = {"nvim-tree/nvim-web-devicons"}
  },
  {
    "kmonad/kmonad-vim",
    ft = { "kbd" }
  },
  {
    "chrisbra/csv.vim",
    ft = { "csv" }
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Telescope                         │
  -- ╰──────────────────────────────────────────────────────────╯
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "fzf",
  --     "ahmedkhalf/project.nvim",
  --     "tsakirist/telescope-lazy.nvim",
  --     "nvim-telescope/telescope-file-browser.nvim",
  --   },
  --   event = { "BufReadPost", "BufNewFile" },
  --   config = function()
  --     require("stephanspiegel.telescope")
  --   end,
  -- },
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build = "make",
  --   name = "fzf"
  -- },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                           git                            │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = "fugitive"
  },
  {
    "rickhowe/spotdiff.vim", -- show diffs per selection
    event = "BufRead"
  },
  {
    "rickhowe/diffchar.vim", -- show diff character by character
    event = "BufRead"
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim", -- wrapper for git-worktrees
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("git_worktree")
      vim.cmd([[ command! WorktreeList lua require('telescope').extensions.git_worktree.git_worktrees() ]])
      vim.cmd([[ command! WorktreeCreate lua require('telescope').extensions.git_worktree.create_git_worktree() ]])
    end,
    event = "BufRead",
    cmd = {
      "WorktreeList",
      "WorktreeCreate"
    }
  },
}
-- ├──────────────────────────────────────────────────────────┤

return plugin_specifications
