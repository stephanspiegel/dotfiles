-- ╭──────────────────────────────────────────────────────────╮
-- │                        Completion                        │
-- ╰──────────────────────────────────────────────────────────╯
  kind_icons = {
    Text = '',
    Method = 'm',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  }
-- find more here: https://www.nerdfonts.com/cheat-sheet

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

    cmp.setup {
      completion = {
        completeopt = "menu,menuone,noinsert"
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
          else
            fallback()
          end
        end, {"i","s","c",}),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[NVIM_LUA]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            rg = "[Ripgrep]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "buffer" },
        { name = "luasnip" },
        { name = "neorg" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "rg" },
        -- { name = "vsnip" },
      },

      window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
      },
      experimental = {
        ghost_text = true,
        native_menu = false,
      },
    }
    cmp.setup.filetype("beancount", {
      sources = {
        {
          name = "buffer",
          entry_filter = function(entry, _)
            return not vim.tbl_contains(beancount_ignore_patterns, entry:get_word())
          end
        },
        { name = "luasnip" },
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
    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
    })

  end,
  dependencies = {
    "hrsh7th/cmp-buffer" , -- buffer completions
    "hrsh7th/cmp-path" , -- path completions
    "hrsh7th/cmp-cmdline" , -- cmdline completions
    "hrsh7th/cmp-nvim-lsp" , -- lsp completions
    "lukas-reineke/cmp-rg" , -- ripgrep everything
    "hrsh7th/cmp-nvim-lua" , -- source for neovim Lua API
    "hrsh7th/cmp-nvim-lsp-signature-help", -- display function signatures with current parameter emphasized
    "hrsh7th/cmp-vsnip", -- vscode snippets?
    "hrsh7th/vim-vsnip", -- vscode snippets?
    -- snippets
    "L3MON4D3/LuaSnip" , -- snippet engine
    "saadparwaiz1/cmp_luasnip" , -- snippet completions
    "crispgm/cmp-beancount", -- beancount completions
  }
}
