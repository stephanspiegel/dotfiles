local exec = function(command)
  vim.api.nvim_exec(command, false)
end

local project_name = function()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local set_title_to_project_name = function()
  local title_string = string.lower(project_name())
  vim.o.titlestring = title_string
end

-- automatically set the window title to the name of the root directory
exec([[
  augroup project_title
    autocmd!
    autocmd DirChanged * lua require'stephanspiegel.title'.set_title_to_project_name()
  augroup END
]])

-- manually set the window title
vim.cmd('command -nargs=1 Title set titlestring=<args>')

return {
  project_name = project_name
}
