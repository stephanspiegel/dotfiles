local status_ok, projects = pcall(require, 'project_nvim')
if not status_ok then
  return
end
projects.setup {
  -- Show hidden files in telescope
  show_hidden = true,
  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = false,
}
local telescope_status_ok, telescope = pcall(require, 'telescope')
if telescope_status_ok then
  telescope.load_extension('projects')
end
