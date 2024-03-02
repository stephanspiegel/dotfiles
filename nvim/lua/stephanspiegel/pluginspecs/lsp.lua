-- ╭──────────────────────────────────────────────────────────╮
-- │                           LSP                            │
-- ╰──────────────────────────────────────────────────────────╯
return {
  {
    "williamboman/mason.nvim",  -- package manager for LSP servers, DAP servers, linters, and formatters
    cmd = "Mason",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      config = function (_, opts)
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        mason.setup(opts)
        mason_lspconfig.setup({
          ensure_installed = {
            "apex_ls",
            "cssls",
            "html",
            "jsonls",
            "lua_ls",
            "prettierd",
            "rust_analyzer",
            "selene",
            "stylua",
            "tsserver",
          },
          -- auto-install configured servers (with lspconfig)
          automatic_installation = true, -- not the same as ensure_installed
        })
      end,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      require("stephanspiegel.lsp")
    end
  },
  {
    "nvimtools/none-ls.nvim", -- use LSP API with linters that aren't strictly speaking LSPs
    config = function()
      require("stephanspiegel.pluginconfigs.null-ls")
    end,
    dependencies = { 
        "nvim-lua/plenary.nvim" ,
        "nvimtools/none-ls-extras.nvim"
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("stephanspiegel.pluginconfigs.nvim-dap")
    end,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    }
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    config = function()
      local dap = require"dap"
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }
      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
    end,
    dependencies = { "mfussenegger/nvim-dap" }
  },
}
