local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end

local actions = require("telescope.actions")
local maputil = require("stephanspiegel.maputil")
telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
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
	},
})
maputil.nmap_all({
	{ "<leader>p", "<cmd>lua require('telescope').extensions.projects()<cr>" },
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({no_ignore=true, hidden=true})<cr>" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
	{ "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
	{ "<leader>c", "<cmd>lua require('telescope.builtin').commands()<cr>" },
	{ "<leader>hc", "<cmd>lua require('telescope.builtin').command_history()<cr>" },
	{ "<leader>hs", "<cmd>lua require('telescope.builtin').search_history()<cr>" },
	{ "<leader>cs", "<cmd>lua require('telescope.builtin').colorscheme()<cr>" },
	{ "<leader>rg", "<cmd>lua require('telescope.builtin').grep_string()<cr>" },
	{ "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>" },
})

if vim.fn.has("unix") == 1 then
	telescope.load_extension("fzf")
end
