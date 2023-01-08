local null_ls = require("null-ls")
local builtins = null_ls.builtins
local pmd = require'stephanspiegel.pluginconfigs.pmd'.pmd

local sources = {
    builtins.formatting.codespell,
    builtins.formatting.eslint_d,
    builtins.formatting.fixjson,
    builtins.formatting.prettierd.with({
        extra_filetypes = { 'apex', 'apexcode' }
    }),
    builtins.formatting.shellharden,
    builtins.formatting.shfmt,
    builtins.formatting.stylelint,
    builtins.formatting.stylua,
    builtins.formatting.xmllint,
    builtins.diagnostics.cspell.with({
        filetypes = { 'html', 'json', 'yaml', 'markdown', 'text' }
    }),
    builtins.diagnostics.codespell,
    builtins.diagnostics.shellcheck,
    builtins.diagnostics.write_good,
    builtins.code_actions.gitsigns,
    builtins.code_actions.shellcheck,
    pmd
}

null_ls.setup({ sources = sources })

