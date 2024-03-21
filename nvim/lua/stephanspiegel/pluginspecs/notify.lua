local nonicons_extention = require("nvim-nonicons.extentions.nvim-notify")

return {
  "rcarriga/nvim-notify", -- notification popups
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {'<Leader>n', mode = { "n" }, function() require('notify').dismiss({pendint = true, silent = true}) end, desc  = "Dismiss notification"}
  },
  opts = {  
    icons = nonicons_extention.icons,
  },
  config = function()
    vim.notify = require'notify'
  end,
  lazy = false
}
