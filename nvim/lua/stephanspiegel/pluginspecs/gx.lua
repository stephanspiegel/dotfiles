return {
  "chrishrb/gx.nvim",
  event = { "BufEnter" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function() require("gx").setup {
    handlers = {
      plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
      github = true, -- open github issues
      brewfile = true, -- open Homebrew formulaes and casks
      package_json = true, -- open dependencies from package.json
      search = true, -- search the web/selection on the web if nothing else is found
    },
    handler_options = {
      search_engine = "duckduckgo", -- you can select between google, bing, duckduckgo, and ecosia
    },
  } end,
}
