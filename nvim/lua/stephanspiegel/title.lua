local exec = function(command)
  vim.api.nvim_exec(command, false)
end

local project_name_by_path = {
  ['/home/stephan'] = '~'
}

local project_name = function()
  local cwd = vim.fn.getcwd()
  if vim.tbl_contains(vim.tbl_keys(project_name_by_path), cwd) then
    return project_name_by_path[cwd]
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local set_vim_title = function(title)
  vim.o.titlestring = string.format(' %s', title)
end

local set_title_to_project_name = function()
  local title_string = string.lower(project_name())
  set_vim_title(title_string)
end

-- automatically set the window title to the name of the root directory
exec([[
  augroup project_title
    autocmd!
    autocmd DirChanged * lua require'stephanspiegel.title'.set_title_to_project_name()
  augroup END
]])

-- manually set the window title
vim.cmd [[command -nargs=1 Title call luaeval('require"stephanspiegel.title".set_vim_title(_A)', <q-args>)]]

return {
  project_name = project_name,
  set_title_to_project_name = set_title_to_project_name,
  set_vim_title = set_vim_title
}
