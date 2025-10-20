-- ╭──────────────────────────────────────────────────────────╮
-- │                        Beancount                         │
-- ╰──────────────────────────────────────────────────────────╯

return {
  {
    "polarmutex/beancount.nvim",
    ft="beancount",
    config = function ()
        vim.api.nvim_create_autocmd( {'BufRead', 'BufNewFile'},
          {
            pattern = {'*.beancount'},
            command = "python3 import sys; sys.path.append('<venv path>/lib/python3.11/site-packages'); import beancount; sys.path.pop()"
          }
      )
    end
  },
  {
    "crispgm/cmp-beancount",
    dependencies = { "jmcantrell/vim-virtualenv" },
    ft="beancount"
  },
  {
    "nathangrigg/vim-beancount",
    ft="beancount",
    dependencies = { "jmcantrell/vim-virtualenv" },
    config = function ()
      vim.g.beancount_separator_col = 70
    end,
    keys={
      { '=', ":'<,'>AlignCommodity<CR>", mode = 'v', desc = 'Align on decimal point'},
    }
  },
}
