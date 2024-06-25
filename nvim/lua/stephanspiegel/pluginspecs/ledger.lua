-- ╭──────────────────────────────────────────────────────────╮
-- │                        Beancount                         │
-- ╰──────────────────────────────────────────────────────────╯

return {
  {
    "polarmutex/beancount.nvim",
    ft="beancount"
  },
  {
    "crispgm/cmp-beancount",
    ft="beancount"
  },
  {
    "nathangrigg/vim-beancount",
    ft="beancount",
    config = function ()
      vim.g.beancount_separator_col = 70
    end,
    keys={
      { '=', ":'<,'>AlignCommodity<CR>", mode = 'v', desc = 'Align on decimal point'},
      {
        '<C-T>',
        '<ESC>:lua require("flash").toggle(false)<CR>?[0-9.]\\+<CR>c//e<CR><C-R>=luaeval("require \'stephanspiegel.functions\'.taxify(_A)", str2float(@"))<CR><ESC>:nohlsearch<CR>:lua require("flash").toggle(true)<CR>a',
        mode = 'i',
        desc = 'Add Maine state sales tax',
        ft = 'beancount'
      },
      {
        '<C-T>',
        '"xygvc<C-R>=luaeval("require \'stephanspiegel.functions\'.taxify(_A)", str2float(@x))<CR><ESC>',
        mode = 'v',
        desc = 'Add Maine state sales tax',
        ft = 'beancount'
      }
    }
  },
}
