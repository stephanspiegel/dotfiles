local maputil = require"stephanspiegel.maputil"

vim.notify = require'notify'
maputil.nmap('<Leader>n', ":lua require('notify').dismiss({pendint = true, silent = true})<CR>")

