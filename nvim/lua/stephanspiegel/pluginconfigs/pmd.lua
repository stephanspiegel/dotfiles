local methods = require('null-ls.methods').internal
local helpers = require("null-ls.helpers")

local pmd_command = 'pmd'

-- PMD "priorities" range from 1 (most serious) to 5 (least serious)
-- We'll map them as 1 or 2 = error, 3 = warn, etc
local severities = {
	vim.diagnostic.severity.ERROR,
	vim.diagnostic.severity.ERROR,
	vim.diagnostic.severity.WARN,
	vim.diagnostic.severity.INFO,
	vim.diagnostic.severity.HINT
}

-- PMD version 6.41.0 introduces two changes:
-- 1. GNU-syle long options format (`--rulesets` instead of `-rulesets`)
-- 2. A `--version` option
-- We need to account for different options because of 1., and can use 2. to decide which style to use
local pmd_version_lessthan_6_41_0 = function()
    vim.fn.system(pmd_command..' --version')
    if vim.v.shell_error == 0 then
        return false
    end
    return true
end

-- Cache the rulesets to use by project root
local rulesets_by_root = {}
local get_rulesets = function(root_directory)
    local roots = vim.tbl_keys(rulesets_by_root)
    if vim.tbl_contains(roots, root_directory) then
        return rulesets_by_root[root_directory]
    end
    local config_dir = root_directory..'/config'
    local config_rulesets = vim.fn.globpath(config_dir, '*ruleset.xml', 1, 1)
    local root_rulesets = vim.fn.globpath(root_directory, '*ruleset.xml')
    local ruleset_files = {}
    if type(config_rulesets) == 'table' then
        vim.list_extend(ruleset_files, config_rulesets)
    end
    if type(root_rulesets) == 'table' then
        vim.list_extend(ruleset_files, root_rulesets)
    end
    rulesets_by_root[root_directory] = table.concat(ruleset_files, ',')
    return rulesets_by_root[root_directory]
end

local using_legacy_pmd

local build_args = function(root_directory)
    using_legacy_pmd = using_legacy_pmd or pmd_version_lessthan_6_41_0()
    local parameters = {
        ['--rulesets'] = get_rulesets(root_directory),
        ['--dir'] = root_directory,
        ['--cache'] = root_directory..'/.pmdCache',
        ['--format'] = 'json'
    }
    if using_legacy_pmd then
        local legacy_parameters = {}
        for parameter, _ in pairs(parameters) do
            local legacy_parameter = parameter:sub(2)
            legacy_parameters[legacy_parameter] = parameters[parameter]
        end
        parameters = legacy_parameters
    end
    local parameter_list = {}
    for parameter_name, value in pairs(parameters) do
        table.insert(parameter_list, parameter_name)
        table.insert(parameter_list, value)
    end
    return parameter_list
end

local pmd = {
    name = 'pmd-apex',
    method = methods.DIAGNOSTICS,
    filetypes = {'apex', 'apexcode', 'apex-anon'},
    generator = helpers.generator_factory({
        args = function(params) return build_args(params.root) end,
        check_exit_code = {0,4},
        command = pmd_command,
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

return { pmd = pmd }
