
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Telescope                         │
-- ╰──────────────────────────────────────────────────────────╯
local builtin = require('telescope.builtin')
local icons = require("nvim-nonicons")

-- from lazy/lua/lazy/core/plugin.lua
local get_name = function(pkg)
  local name = pkg:sub(-4) == ".git" and pkg:sub(1, -5) or pkg
  name = name:sub(-1) == "/" and name:sub(1, -2) or name
  local slash = name:reverse():find("/", 1, true) --[[@as number?]]
  return slash and name:sub(#name - slash + 2) or pkg:gsub("%W+", "_")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "fzf",
      "ahmedkhalf/project.nvim",
      "tsakirist/telescope-lazy.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    keys = function ()
      return {
        { "<leader>p", require'telescope'.extensions.projects.projects, desc = 'Open [P]roject' },
        { "<leader>ff", function() builtin.find_files({no_ignore=true, hidden=true}) end, desc = '[F]ind [F]iles' },
        { "<leader>fg", builtin.live_grep, desc = '[F]ind contents using Live [G]rep' },
        { "<leader>b", builtin.buffers, desc = 'Open [B]uffer' },
        { "<leader>fh", builtin.help_tags, desc = '[F]ind [H]elp' },
        { "<leader>c", builtin.commands, desc = 'Show neovim [C]ommands' },
        { "<leader>hc", builtin.command_history, desc = '[H]istory of [C]ommands' },
        { "<leader>hs", builtin.search_history, desc = '[H]istory of [S]earches' },
        {
          "<leader>cs",
          function()
            local specs = require'stephanspiegel.pluginspecs.colorschemes'
            local packagenames = {}
            for _, spec in pairs(specs) do
              local package_name = spec.name or get_name(spec[1])
              print(spec[1].. ' '..package_name)
              table.insert(packagenames, package_name)
            end
            require'lazy'.load({plugins=packagenames, wait=true})
            builtin.colorscheme()
          end,
          desc = 'Change [C]olor [S]cheme'
        },
        { "<leader>rg", builtin.grep_string, desc = 'Search string under cursor (like [R]ip[G]rep)' },
        { "<leader>gb", builtin.git_branches, desc = 'Work with [G]it [B]ranches' },
        { "<leader>qf", builtin.quickfix, desc = 'Populate Telescope with items in [Q]uick [F]ix' },
        { "<leader>fb", require'telescope'.extensions.file_browser.file_browser, desc = 'Open [F]ile [B]rowser' },
        { "<leader>sd", builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
      }
    end,

    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = actions.which_key,
              ["<ESC>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
          colorscheme = { enable_preview = true },
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          lazy = {
            -- Whether or not to show the icon in the first column
            show_icon = true,
            -- Mappings for the actions
            mappings = {
              open_in_browser = "<C-o>",
              open_in_file_browser = "<M-b>",
              open_in_find_files = "<C-f>",
              open_in_live_grep = "<C-g>",
              open_plugins_picker = "<C-b>", -- Works only after having called first another action
              open_lazy_root_find_files = "<C-r>f",
              open_lazy_root_live_grep = "<C-r>g",
            },
          },
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true
          }
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      if vim.fn.has("unix") == 1 then
        telescope.load_extension("fzf")
      end
      telescope.load_extension("dap")
      telescope.load_extension("lazy")
      telescope.load_extension("projects")
      telescope.load_extension("file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    name = "fzf"
  },
}
