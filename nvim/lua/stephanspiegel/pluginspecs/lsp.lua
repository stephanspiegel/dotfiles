-- ╭──────────────────────────────────────────────────────────╮
-- │                           LSP                            │
-- ╰──────────────────────────────────────────────────────────╯
return {
  {
    "williamboman/mason.nvim",  -- package manager for LSP servers, DAP servers, linters, and formatters
    cmd = "Mason",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim"
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    ensure_installed = {
      "apex-language-server",
      "beancount-language-server",
      "css-lsp",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      "prettierd",
      "rust-analyzer",
      "selene",
      "stylua",
      "typescript-language-server",
    },
    auto_update = true,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
    debounce_hours = 8
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
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function ()
        -- Disable virtual_text since it's redundant due to lsp_lines.
        vim.diagnostic.config({
          virtual_text = false,
        })
        require("lsp_lines").setup()
    end,
    dependencies = { "neovim/nvim-lspconfig" },
    event = { "BufReadPost", "BufNewFile" },
  }
}
