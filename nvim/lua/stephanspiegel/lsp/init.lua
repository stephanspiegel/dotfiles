local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig not found")
    return
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>=', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float({ scope = "line", border = "rounded" }) end)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = require("stephanspiegel.lsp.settings.lua_ls")
}

lspconfig.apex_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    apex_jar_path = vim.fn.stdpath("data")..'/mason/packages/apex-language-server/extension/dist/apex-jorje-lsp.jar',
    apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
    apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
}

lspconfig.jsonls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.beancount.setup {
    init_options = {
        journal_file = "~/ledger/beancount/main.beancount",
    };
};

-- Hacking in my new servers
-- See https://github.com/williamboman/mason.nvim/discussions/189
local index = require("mason-registry.index")
index["soql_ls"] = "stephanspiegel.lsp.soql-lsp"

-- local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
-- Check if it's already defined for when reloading this file.
if not configs.soql_ls then
    configs.soql_ls = {
        default_config = {
            cmd = {'soql-ls', '--stdio'},
            filetypes = {'soql'},
            root_dir = lspconfig.util.root_pattern('sfdx-project.json'),
            settings = {},
        }
    }
end

lspconfig.soql_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
