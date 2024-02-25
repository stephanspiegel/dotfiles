-- ╭──────────────────────────────────────────────────────────╮
-- │                        Completion                        │
-- ╰──────────────────────────────────────────────────────────╯
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local beancount_ignore_patterns = {
  "USD",
  "EUR",
  "CHF"
}

return {
  "hrsh7th/nvim-cmp",-- The completion plugin
  event = "InsertEnter",
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- loads vscode style snippets (eg from friendly-snippets)
    require("luasnip/loaders/from_vscode").lazy_load()
    cmp.setup {
      completion = {
        completeopt = "menu,menuone,preview,noselect"
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = {
        ["<C-k>"] = function()
          if luasnip.choice_active() then
            luasnip.change_choice(-1)
          else
            cmp.mapping.select_prev_item()
          end
        end,
        ["<C-j>"] = function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          else
            cmp.mapping.select_next_item()
          end
        end,
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
            "i",
            "s",
            "c",
          }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
            "i",
            "s",
            "c",
          }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "rg" },
        { name = 'beancount',
          option = {
            account = '~/ledger/beancount/meta.beancount'
          }
        }
      }
    }
    cmp.setup.filetype("beancount", {
      sources = {
        {
          name = "buffer",
          entry_filter = function(entry, ctx)
            return not vim.tbl_contains(beancount_ignore_patterns, entry:get_word())
          end
        },
        {
          name = "beancount",
          option = {
            account = "~/ledger/beancount/meta.beancount"
          },
        }
      },
      experimental = {
        ghost_text = true,
        native_menu = false,
      },
    })

  end,
  dependencies = {
    "hrsh7th/cmp-buffer" , -- buffer completions
    "hrsh7th/cmp-path" , -- path completions
    "hrsh7th/cmp-cmdline" , -- cmdline completions
    "hrsh7th/cmp-nvim-lsp" , -- lsp completions
    "lukas-reineke/cmp-rg" , -- ripgrep everything
    "hrsh7th/cmp-nvim-lua" , -- source for neovim Lua API
    -- snippets
    "L3MON4D3/LuaSnip" , -- snippet engine
    "saadparwaiz1/cmp_luasnip" , -- snippet completions
    "rafamadriz/friendly-snippets" , -- a bunch of snippets to use
    "crispgm/cmp-beancount", -- beancount completions
  }
}
