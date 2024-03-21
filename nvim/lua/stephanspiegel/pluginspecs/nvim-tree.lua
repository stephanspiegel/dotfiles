local nonicons_extention = require("nvim-nonicons.extentions.nvim-tree")

return {
  "kyazdani42/nvim-tree.lua",
  keys = {
    {'<Leader>e', ':NvimTreeToggle<cr>', desc = 'Toggle NvimTree'}
  },
  opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
  update_focused_file = {
      enable = true,
      update_cwd = true,
      update_root = true,
      ignore_list = {},
    },
      git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
      view = {
      width = 30,
      side = "left",
      number = false,
      relativenumber = false,
    },
      actions = {
      change_dir = {
        global = true,
      },
    },
      renderer = {
    icons = {
      glyphs = nonicons_extention.glyphs,
    },
    }
  },
}
