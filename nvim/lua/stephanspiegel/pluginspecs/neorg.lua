return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "~/notes",
            open_last_workspace = true
          },
        },
        ["core.journal"] = {
          config = {
            strategy = '%Y-%m-%d-%a',
            workspace = '~/notes'
          }
        }
      },
    }
  end,
  cmd = { 'Neorg' }
}
