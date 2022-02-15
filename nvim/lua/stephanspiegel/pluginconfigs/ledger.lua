vim.g.ledger_default_commodity = 'USD'
vim.g.ledger_commodity_before = 0
vim.g.ledger_commodity_sep = ' '
vim.g.ledger_decimal_sep = '.'
vim.g.ledger_date_format = '%Y-%m-%d'
vim.g.ledger_align_at = 60
vim.g.ledger_bin = '/usr/bin/ledger'
vim.g.ledger_main = '~/ledger/personal/main.ledger'
vim.g.ledger_extra_options = ' --pedantic --explicit --check-payees'

local mapkeys = require('stephanspiegel.mapkeys')
mapkeys.nmap('<leader>c', ":call ledger#transaction_state_toggle(line('.'), ' *')<CR>")
mapkeys.imap_all(
{ { '<Tab>', '<C-r>=ledger#autocomplete_and_align()<CR>'}
, { '<C-T>', '<ESC>?[0-9.]\\+<CR>c//e<CR><C-R>=luaeval("require \'stephanspiegel.pluginconfigs.ledger\'.taxify(_A)", str2float(@"))<CR><ESC>:nohlsearch<CR>a' }
})
mapkeys.vmap_all(
{ {'<Tab>', ':LedgerAlign<CR>'}
, {'<C-T>', '"xygvc<C-R>=luaeval("require \'stephanspiegel.pluginconfigs.ledger\'.taxify(_A)", str2float(@x))<CR><ESC>'}
})

-- turn off completion for ledger, where it interferes with plugin provided completion
vim.api.nvim_command([[
  autocmd FileType ledger* lua require 'cmp'.setup.buffer { enabled = false }
]])

local taxify = function(amount)
  return string.format('%.2f', amount * 1.055)
end

return {
  taxify = taxify
}
