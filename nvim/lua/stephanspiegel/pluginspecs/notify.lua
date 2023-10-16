return {
  "rcarriga/nvim-notify", -- notification popups
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {'<Leader>n', mode = { "n" }, function() require('notify').dismiss({pendint = true, silent = true}) end, desc  = "Dismiss notification"}
  },
  config = function()
    vim.notify = require'notify'
  end,
  lazy = false
}
