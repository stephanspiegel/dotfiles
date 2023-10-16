local enable_venn = function()
  vim.notify'Venn mode ON'
  vim.b.venn_enabled = true
  vim.cmd[[setlocal ve=all]]
  -- draw a line on HJKL keystokes
  vim.keymap.set('n', 'J', '<C-v>j:VBox<CR>', { buffer = true, noremap = true })
  vim.keymap.set('n', 'K', '<C-v>k:VBox<CR>', { buffer = true, noremap = true })
  vim.keymap.set('n', 'L', '<C-v>l:VBox<CR>', { buffer = true, noremap = true })
  vim.keymap.set('n', 'H', '<C-v>h:VBox<CR>', { buffer = true, noremap = true })
  -- draw a box by pressing "f" with visual selection
  vim.keymap.set('v', 'f', ':VBox<CR>', { buffer = true, noremap = true })
end

local reset_venn = function()
  vim.notify'Venn mode OFF'
  vim.cmd[[setlocal ve=]]
  vim.cmd[[mapclear <buffer>]]
  vim.b.venn_enabled = nil
end

local toggle_venn = function()
  local toggle_func = vim.b.venn_enabled and reset_venn or enable_venn
  toggle_func()
end
return {
    "jbyuki/venn.nvim", -- Diagrams in vim
    keys = {
      { "<leader>v", function() toggle_venn() end, mode = 'n', desc = 'Toggle Venn mode' }
    },
    -- config = function()
    --   require("stephanspiegel.pluginconfigs.venn")
    -- end,
}
