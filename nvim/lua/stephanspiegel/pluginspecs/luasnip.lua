return {
  'L3MON4D3/LuaSnip',
  build = (function()
    -- Build Step is needed for regex support in snippets.
    -- This step is not supported in many windows environments.
    -- Remove the below condition to re-enable on windows.
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  config = function()
    require("luasnip.loaders.from_lua").lazy_load {
      paths = vim.fn.stdpath "config" .. "/lua/stephanspiegel/snippets",
    }
  end,
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function()
        -- loads vscode style snippets
        require("luasnip/loaders/from_vscode").lazy_load()
      end,
    },
  },
}
