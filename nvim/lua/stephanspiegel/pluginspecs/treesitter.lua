-- ╭──────────────────────────────────────────────────────────╮
-- │                        Treesitter                        │
-- ╰──────────────────────────────────────────────────────────╯
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.soql = {
--   install_info = {
--     url = "~/Projects/vim/tree-sitter-soql",
--     files = {"src/parser.c"},
--     branch = "main",
--     generate_requires_npm = false,
--     requires_generate_from_grammar = false,
--   },
--   filetype = "soql",
-- }

-- vim.treesitter.language.register('soql', 'soql')
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "apex",
          "bash",
          "c_sharp",
          "css",
          "haskell",
          "html",
          "http",
          "javascript",
          "json",
          "ledger",
          "lua",
          "markdown",
          "nix",
          "norg",
          "python",
          "query",
          "regex",
          "rust",
          "soql",
          "sosl",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        ignore_install = { "" }, -- List of parsers to ignore installing
        autopairs = {
          enable = true
        },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "" }, -- list of language that will be disabled
          additional_vim_regex_highlighting = true,

        },
        indent = { enable = true, disable = { "yaml" } },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/playground",
    build = ":TSInstall query"
  }
}
