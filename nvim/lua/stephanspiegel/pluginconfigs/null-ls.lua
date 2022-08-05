local null_ls = require("null-ls")
local pmd = require'stephanspiegel.pluginconfigs.pmd'.pmd

local sources = {
    null_ls.builtins.formatting.codespell,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.xmllint,
    null_ls.builtins.diagnostics.cspell.with({
        filetypes = { 'html', 'json', 'yaml', 'markdown', 'text' }
    }),
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    pmd
}

null_ls.setup({ sources = sources })

