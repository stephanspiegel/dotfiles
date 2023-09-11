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
    "windwp/nvim-autopairs",
    config = function()
      require("stephanspiegel.pluginconfigs.autopairs")
    end,
    event = "InsertEnter",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    event = { "BufReadPost", "BufNewFile" },
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
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Navigation                        │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("stephanspiegel.pluginconfigs.nvim-tree")
    end,
    keys = {
      {'<Leader>e', ':NvimTreeToggle<cr>', desc = 'Toggle NvimTree'}
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { 'kkharji/sqlite.lua' }
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
    cmd = { "Vista" }
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
    "rcarriga/nvim-notify", -- notification popups
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("stephanspiegel.pluginconfigs.notify")
    end,
    lazy = false
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
    dependencies = { "devicons", opt = true },
    config = function()
      require("stephanspiegel.pluginconfigs.lualine")
    end,
    event = "VeryLazy"
  },
  {
    'goolord/alpha-nvim', -- startup dashboard
    dependencies = { 'devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end,
    lazy = false
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                 Languages and filetypes                  │
  -- ╰──────────────────────────────────────────────────────────╯
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
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                        Completion                        │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "hrsh7th/nvim-cmp",-- The completion plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer" , -- buffer completions
      "hrsh7th/cmp-path" , -- path completions
      "hrsh7th/cmp-cmdline" , -- cmdline completions
      "hrsh7th/cmp-nvim-lsp" , -- lsp completions
      "lukas-reineke/cmp-rg" , -- ripgrep everything    "hrsh7th/cmp-nvim-lua" , -- source for neovim Lua API
        -- snippets
      "saadparwaiz1/cmp_luasnip" , -- snippet completions
      "L3MON4D3/LuaSnip" , -- snippet engine
      "rafamadriz/friendly-snippets" , -- a bunch of snippets to use
    }
  },
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
    event = "VeryLazy"
  },
  {
    "folke/trouble.nvim",
    dependencies = "devicons",
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
      "fzf",
      "ahmedkhalf/project.nvim",
      "tsakirist/telescope-lazy.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("stephanspiegel.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "p00f/nvim-ts-rainbow" }, -- highlight brackets in matching colors
  { "nvim-treesitter/playground",
    build = ":TSInstall query"
  },
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
    "lewis6991/gitsigns.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.gitsigns")
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("stephanspiegel.pluginconfigs.diffview")
    end,
    event = "BufRead"
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
  { 
    "rcaputo/vim-ledger_x",
    ft = "ledger"
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │                         Diagrams                         │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "jbyuki/venn.nvim", -- Diagrams in vim
    keys = {
      { "<leader>v" }
    },
    config = function()
      require("stephanspiegel.pluginconfigs.venn")
    end,
  },
  {
    "willchao612/vim-diagon", -- Simple Unicode or ASCII diagrams
    config = function()
      vim.g.diagon_use_echo = 1 --- Use echo instead of replacing original text directly
    end,
    cmd = "Diagon"
  },
  {
    "LudoPinelli/comment-box.nvim", -- Draw boxes around comments
    cmd = {
      "CBllbox",
      "CBlcbox",
      "CBlrbox",
      "CBclbox",
      "CBccbox",
      "CBcrbox",
      "CBrlbox",
      "CBrcbox",
      "CBrrbox",
      "CBalbox",
      "CBacbox",
      "CBarbox",
    }
  },
  {
    "dhruvasagar/vim-table-mode",
    cmd = {
      "TableModeToggle",
      "TableModeEnable",
      "TableModeDisable",
      "Tableize",
      "TableModeRealign",
      "TableAddFormula",
      "TableEvalFormulaLine",
      "TableSort",
    }
  }
}

-- ├──────────────────────────────────────────────────────────┤

return plugin_specifications
