local null_ls = require("null-ls")
local builtins = null_ls.builtins
local pmd = require'stephanspiegel.pluginconfigs.pmd'.pmd

local sources = {
    builtins.formatting.codespell,
    builtins.formatting.prettierd.with({
        extra_filetypes = { 'apex', 'apexcode' }
    }),
    builtins.formatting.shellharden,
    builtins.formatting.shfmt,
    builtins.formatting.stylelint,
    builtins.formatting.stylua,
    builtins.diagnostics.cspell.with({
        filetypes = { 'html', 'json', 'yaml', 'markdown', 'text' }
    }),
    builtins.diagnostics.codespell,
    builtins.diagnostics.write_good,
    builtins.code_actions.gitsigns,
    pmd
}

null_ls.setup({ sources = sources })

