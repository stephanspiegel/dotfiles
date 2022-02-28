local plugin_specifications =
{ { 'wbthomason/packer.nvim' }          -- Have packer manage itself
, { 'nvim-lua/popup.nvim' }             -- An implementation of the Popup API from vim in Neovim
, { 'nvim-lua/plenary.nvim' }           -- Useful lua functions used by lots of plugins
, { 'psliwka/vim-smoothie' }            -- smooth scrolling
, { 'tpope/vim-surround' }              -- surround with quotes, brackets, etc.
, { 'fcpg/vim-spotlightify' }           -- Highlighted search results, improved
, { 'tpope/vim-unimpaired' }
, { 'tpope/vim-sleuth' }                -- automatically set tabstop
, { 'windwp/nvim-autopairs'
  , config = function () require'stephanspiegel.pluginconfigs.autopairs' end
  }
, { 'numToStr/Comment.nvim'
  , config = function() require'Comment'.setup() end
  }
, { 'kyazdani42/nvim-web-devicons' }
, { 'kyazdani42/nvim-tree.lua'
  , config = function () require'stephanspiegel.pluginconfigs.nvim-tree' end
  }
, { 'startup-nvim/startup.nvim'
  , requires = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}
  , config =
      function() require'startup'.setup() end
  }
, { 'ahmedkhalf/project.nvim'
  , config = function() require'stephanspiegel.pluginconfigs.projects' end
  }
, { 'rmagatti/auto-session'
  , config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = false,
        auto_session_suppress_dirs = nil
      }
    end
  }
, { "jbyuki/venn.nvim"                  -- Diagrams in vim
  , config = function() require('stephanspiegel.pluginconfigs.venn') end
  }
, { 'sudormrfbin/cheatsheet.nvim'       -- cheat sheets with telescope UI
  , requires =
    { {'nvim-telescope/telescope.nvim'}
    , {'nvim-lua/popup.nvim'}
    , {'nvim-lua/plenary.nvim'}
    }
  }
, { 'lukas-reineke/indent-blankline.nvim' }
, { 'jremmen/vim-ripgrep' }
, { 'xiyaowong/nvim-transparent' }
, { 'liuchengxu/vista.vim'
  , config = function()
      vim.g.vista_default_executive = 'nvim_lsp'
      vim.g.vista_fzf_preview = {'right:50%'}
    end
  }
, { 'feline-nvim/feline.nvim'
  , config = function()
      require('feline').setup()
    end
  }
, { 'vhyrro/neorg'                      -- Neorg, "orgmode" for neovim
    , config = function() require('stephanspiegel.pluginconfigs.neorg') end
  }
, { 'ray-x/go.nvim'
  , requires =
    { { 'nvim-treesitter/nvim-treesitter' }
    , { 'nvim-treesitter/nvim-treesitter-textobjects' }
    }
  }
, { '~/Projects/vim/kraftwerk.nvim' }
  -- completion
, { 'hrsh7th/nvim-cmp' }                -- The completion plugin
, { 'hrsh7th/cmp-buffer' }              -- buffer completions
, { 'hrsh7th/cmp-path' }                -- path completions
, { 'hrsh7th/cmp-cmdline' }             -- cmdline completions
, { 'saadparwaiz1/cmp_luasnip' }        -- snippet completions
, { 'lukas-reineke/cmp-rg' }            -- ripgrep everything
, { 'hrsh7th/cmp-nvim-lsp' }            -- lsp completions
, { 'hrsh7th/cmp-nvim-lua' }            -- neovim lua completions
  -- snippets
, { 'L3MON4D3/LuaSnip' }                -- snippet engine
, { 'rafamadriz/friendly-snippets' }    -- a bunch of snippets to use
  -- lsp
, { 'neovim/nvim-lspconfig' }           -- enable LSP
, { 'williamboman/nvim-lsp-installer' } -- simple to use language server installer
, { 'folke/trouble.nvim'
  , requires = "kyazdani42/nvim-web-devicons"
  , config = function() require 'stephanspiegel.pluginconfigs.trouble' end
  }
, { 'jose-elias-alvarez/null-ls.nvim'   -- use LSP API with linters that aren't strictly speaking LSPs
  , config = function() require'stephanspiegel.pluginconfigs.null-ls' end
  , requires = { 'nvim-lua/plenary.nvim' },
  }
  -- telescope
, { 'nvim-telescope/telescope.nvim'
  , requires = {  'nvim-lua/plenary.nvim'  }
  , config = function() require 'stephanspiegel.telescope' end
  }
, { 'nvim-telescope/telescope-fzf-native.nvim'
  , run = 'make'
  }
  -- treesitter
, { 'nvim-treesitter/nvim-treesitter'
  , run = ':TSUpdate'
  , config = function() require 'stephanspiegel.treesitter' end
  }
, { 'nvim-treesitter/nvim-treesitter-textobjects' }
, { 'p00f/nvim-ts-rainbow' }           -- hightlight brackets in matching colors
, { 'nvim-treesitter/playground'
  , run = ':TSInstallQuery' }
  -- git
, { 'tpope/vim-fugitive' }
, { 'lewis6991/gitsigns.nvim'
  , config = function() require 'stephanspiegel.pluginconfigs.gitsigns' end
  , requires = { 'nvim-lua/plenary.nvim' }
  }
, { 'sindrets/diffview.nvim'
  , requires = 'nvim-lua/plenary.nvim'
  , config = function() require 'stephanspiegel.pluginconfigs.diffview' end
  }
  -- ledger
, { 'ledger/vim-ledger'
  , ft = 'ledger'
  , config = function() require 'stephanspiegel.pluginconfigs.ledger' end
  }
, { 'rcaputo/vim-ledger_x' }

}

local colorscheme_specifications =
{ { 'folke/tokyonight.nvim' }
, { 'junegunn/seoul256.vim' }
, { 'mhartington/oceanic-next' }
, { 'morhetz/gruvbox' }
, { 'nightsense/stellarized' }
, { 'rafamadriz/neon' }
, { 'rakr/vim-one' }
, { 'rakr/vim-two-firewatch' }
, { 'rockerBOO/boo-colorscheme-nvim' }
, { 'sainnhe/edge' }
, { 'sainnhe/everforest' }
, { 'sainnhe/forest-night' }
, { 'sainnhe/gruvbox-material' }
, { 'sainnhe/sonokai' }
, { 'savq/melange' }
, { 'smallwat3r/vim-hashpunk-sw' }
, { 'theniceboy/nvim-deus' }
, { 'xstrex/FireCode.vim' }
}

local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer. Close and reopen Neovim...'
  cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

vim.list_extend(plugin_specifications, colorscheme_specifications)
local config_overrides = {}
return packer.startup({plugin_specifications, config_overrides})
