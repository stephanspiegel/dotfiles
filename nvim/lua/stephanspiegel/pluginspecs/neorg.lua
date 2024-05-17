return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  version = "*",
  config = function()
    require("neorg").setup {
      load = {
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "~/notes",
            open_last_workspace = true
          },
        },
        ["core.esupports.indent"] = {},
        ["core.integrations.nvim-cmp"] = {},
        ["core.journal"] = {
          config = {
            strategy = '%Y-%m-%d-%a',
            workspace = '~/notes'
          }
        },
        ["core.pivot"] = {},
        ["core.promo"] = {},
      },
    }
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
  cmd = { 'Neorg' }
}
