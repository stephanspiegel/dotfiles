
-- ╒══════════════════════════════════════════════════════════╕
--                     Theme Specifications
-- ╘══════════════════════════════════════════════════════════╛
local colorscheme_specifications = {
  { "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
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
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        dark_variant = "moon",
      })
    end,
  },
  { "https://gitlab.com/protesilaos/tempus-themes-vim" },
  {
    'kepano/flexoki-neovim',
    name = 'flexoki'
  },
}

return colorscheme_specifications
