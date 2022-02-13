local enable_venn = function()
  print'Toggling Venn ON'
  vim.b.venn_enabled = true
  vim.cmd[[setlocal ve=all]]
  -- draw a line on HJKL keystokes
  vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
  -- draw a box by pressing "f" with visual selection
  vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
end

local reset_venn = function()
  print'Toggling Venn OFF'
  vim.b.venn_enabled = true
  vim.cmd[[setlocal ve=]]
  vim.cmd[[mapclear <buffer>]]
  vim.b.venn_enabled = nil
end

local toggle_venn = function()
  local toggle_func = vim.b.venn_enabled and reset_venn or enable_venn
  toggle_func()
end
--
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua require'stephanspiegel.pluginconfigs.venn'.toggle_venn()<CR>", { noremap = true})

return {
  toggle_venn = toggle_venn
}
