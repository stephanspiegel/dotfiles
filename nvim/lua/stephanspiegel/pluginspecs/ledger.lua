-- ╭──────────────────────────────────────────────────────────╮
-- │                          Ledger                          │
-- ╰──────────────────────────────────────────────────────────╯

return {
  {
    "ledger/vim-ledger",
    config = function ()
      vim.g.ledger_default_commodity = 'USD'
      vim.g.ledger_commodity_before = 0
      vim.g.ledger_commodity_sep = ' '
      vim.g.ledger_decimal_sep = '.'
      vim.g.ledger_date_format = '%Y-%m-%d'
      vim.g.ledger_align_at = 60
      vim.g.ledger_bin = '/usr/bin/ledger'
      vim.g.ledger_main = '~/ledger/personal/main.ledger'
      vim.g.ledger_extra_options = ' --pedantic --explicit --check-payees'
      vim.g.ledger_is_hledger = false
      -- turn off completion for ledger, where it interferes with plugin provided completion
      vim.api.nvim_command([[
        autocmd FileType ledger* lua require 'cmp'.setup.buffer { enabled = false }
        ]])
    end,
    ft = "ledger",
    keys = {
      {'<leader>c', ":call ledger#transaction_state_toggle(line('.'), ' *')<CR>", desc = "Toggle 'cleared' state"},
      { '<Tab>',
        '<C-r>=ledger#autocomplete_and_align()<CR>',
        mode = 'i',
        desc = 'Autocomplete and align',
        ft = 'ledger'
      },
      {
        '<C-T>',
        '<ESC>:lua require("flash").toggle(false)<CR>?[0-9.]\\+<CR>c//e<CR><C-R>=luaeval("require \'stephanspiegel.functions\'.taxify(_A)", str2float(@"))<CR><ESC>:nohlsearch<CR>:lua require("flash").toggle(true)<CR>a',
        mode = 'i',
        desc = 'Add Maine state sales tax',
        ft = 'ledger'
      },
    },
    { '<Tab>',
      ':LedgerAlign<CR>',
      mode = 'v',
      desc = 'Align',
      ft = 'ledger'
    },
    {
      '<C-T>',
      '"xygvc<C-R>=luaeval("require \'stephanspiegel.functions\'.taxify(_A)", str2float(@x))<CR><ESC>',
      mode = 'v',
      desc = 'Add Maine state sales tax',
      ft = 'ledger'
    }
  },
  {
    "rcaputo/vim-ledger_x",
    ft = "ledger"
  },
  -- Beancount
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
      vim.g.beancount_separator_col = 70;
    end,
    keys={
      { '<Tab>', ':AlignCommodity<CR>', mode = 'v', desc = 'Align on decimal point'},
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
  }
}
