local projects = require'project_nvim'

projects.setup {
  -- Show hidden files in telescope
  show_hidden = true,
  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = true,
}
local telescope_status_ok, telescope = pcall(require, 'telescope')
if telescope_status_ok then
  telescope.load_extension('projects')
end
