local null_ls = require("null-ls")

-- PMD "priorities" range from 1 (most serious) to 5 (least serious)
-- We'll map them as 1 or 2 = error, 3 = warn, etc
local severities = {
	vim.diagnostic.severity.ERROR,
	vim.diagnostic.severity.ERROR,
	vim.diagnostic.severity.WARN,
	vim.diagnostic.severity.INFO,
	vim.diagnostic.severity.HINT
}

local methods = require('null-ls.methods').internal
local helpers = require("null-ls.helpers")

local pmd = {
    name = 'pmd-apex',
    method = methods.DIAGNOSTICS,
    filetypes = {'apex', 'apexcode', 'apex-anon'},
    generator = helpers.generator_factory({
        args = {
            '-rulesets', 'rulesets/apex/quickstart.xml',
            --todo 2022-02-18 <stephan@stephanspiegel.com> Stephan Spiegel -- use root directory instead of filename
            '-dir', '$FILENAME',
            --todo 2022-02-18 <stephan@stephanspiegel.com> Stephan Spiegel -- use caching
            '-format', 'json'
        },
        check_exit_code = {0,4},
        command = 'pmd',
        format = 'json',
        ignore_stderr = true,
        multiple_files = true,
        on_output = function(params)
            local diagnostics = {}
            for _, file_result in ipairs(params.output.files) do
                local filename = file_result.filename
                for _, violation in ipairs(file_result.violations) do
                    table.insert(diagnostics, {
                        row = violation.beginline,
                        col = violation.begincolumn,
                        -- Only use end_col if pmd isn't trying to flag multiple lines to avoid visual clutter
                        end_col = violation.endline > violation.beginline and nil or violation.endcolumn,
                        source = "pmd",
                        message = string.format('%s (%s)', violation.description, violation.rule),
                        severity = severities[violation.priority],
                        filename = filename,
                    })
                end
            end
            return diagnostics
        end,
    })
}

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
    null_ls.builtins.diagnostics.cspell,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns,
    pmd
}

null_ls.setup({ sources = sources })

