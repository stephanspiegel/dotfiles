  return {
    "ahmedkhalf/project.nvim",
    config = function()
      require 'project_nvim'.setup{
        -- Show hidden files in telescope
        show_hidden = true,
        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,
      }
    end
  }
