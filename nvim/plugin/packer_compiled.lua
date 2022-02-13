-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/stephan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FireCode.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/FireCode.vim",
    url = "https://github.com/xstrex/FireCode.vim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n›\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0B\3\2\2'\4\b\0&\3\4\3=\3\t\2B\0\2\1K\0\1\0\26auto_session_root_dir\15/sessions/\tdata\fstdpath\afn\bvim\1\0\3\14log_level\tinfo\25auto_session_enabled\2%auto_session_enable_last_session\1\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim",
    url = "https://github.com/sudormrfbin/cheatsheet.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  edge = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/edge",
    url = "https://github.com/sainnhe/edge"
  },
  ["forest-night"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/forest-night",
    url = "https://github.com/sainnhe/forest-night"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*stephanspiegel.pluginconfigs.gitsigns\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kraftwerk.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/kraftwerk.nvim",
    url = "/home/stephan/Projects/vim/kraftwerk.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+stephanspiegel.pluginconfigs.autopairs\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+stephanspiegel.pluginconfigs.nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30stephanspiegel.treesitter\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/oceanic-next",
    url = "https://github.com/mhartington/oceanic-next"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["seoul256.vim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/seoul256.vim",
    url = "https://github.com/junegunn/seoul256.vim"
  },
  sonokai = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/sonokai",
    url = "https://github.com/sainnhe/sonokai"
  },
  ["startup.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fstartup\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/startup.nvim",
    url = "https://github.com/startup-nvim/startup.nvim"
  },
  stellarized = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/stellarized",
    url = "https://github.com/nightsense/stellarized"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29stephanspiegel.telescope\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["venn.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&stephanspiegel.pluginconfigs.venn\frequire\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-hashpunk-sw"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-hashpunk-sw",
    url = "https://github.com/smallwat3r/vim-hashpunk-sw"
  },
  ["vim-ledger"] = {
    config = { "\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(stephanspiegel.pluginconfigs.ledger\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/opt/vim-ledger",
    url = "https://github.com/ledger/vim-ledger"
  },
  ["vim-ledger_x"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-ledger_x",
    url = "https://github.com/rcaputo/vim-ledger_x"
  },
  ["vim-one"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-one",
    url = "https://github.com/rakr/vim-one"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-two-firewatch"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-two-firewatch",
    url = "https://github.com/rakr/vim-two-firewatch"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vista.vim"] = {
    config = { "\27LJ\2\nr\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0K\0\1\0\1\2\0\0\14right:50%\22vista_fzf_preview\rnvim_lsp\28vista_default_executive\6g\bvim\0" },
    loaded = true,
    path = "/home/stephan/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+stephanspiegel.pluginconfigs.nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: startup.nvim
time([[Config for startup.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fstartup\frequire\0", "config", "startup.nvim")
time([[Config for startup.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+stephanspiegel.pluginconfigs.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*stephanspiegel.pluginconfigs.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: venn.nvim
time([[Config for venn.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&stephanspiegel.pluginconfigs.venn\frequire\0", "config", "venn.nvim")
time([[Config for venn.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: vista.vim
time([[Config for vista.vim]], true)
try_loadstring("\27LJ\2\nr\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0K\0\1\0\1\2\0\0\14right:50%\22vista_fzf_preview\rnvim_lsp\28vista_default_executive\6g\bvim\0", "config", "vista.vim")
time([[Config for vista.vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29stephanspiegel.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n›\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0B\3\2\2'\4\b\0&\3\4\3=\3\t\2B\0\2\1K\0\1\0\26auto_session_root_dir\15/sessions/\tdata\fstdpath\afn\bvim\1\0\3\14log_level\tinfo\25auto_session_enabled\2%auto_session_enable_last_session\1\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30stephanspiegel.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType ledger ++once lua require("packer.load")({'vim-ledger'}, { ft = "ledger" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-ledger/ftdetect/ledger.vim]], true)
vim.cmd [[source /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-ledger/ftdetect/ledger.vim]]
time([[Sourcing ftdetect script at: /home/stephan/.local/share/nvim/site/pack/packer/opt/vim-ledger/ftdetect/ledger.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
