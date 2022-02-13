local lspconfig = require 'lspconfig'
local server = require 'nvim-lsp-installer.server'
local servers = require 'nvim-lsp-installer.servers'
local npm = require 'nvim-lsp-installer.installers.npm'
local configs = require 'lspconfig.configs'

local server_name = 'soql'

configs[server_name] = {
    default_config = {
        filetypes = { 'soql' },
        root_dir = lspconfig.util.root_pattern '.git',
    },
}

local root_dir = server.get_server_root_path(server_name)

local soql_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    languages = { 'soql' },
    homepage = 'https://github.com/forcedotcom/soql-language-server',
    installer = npm.packages { '@salesforce/soql-language-server' },
    default_options = {
        cmd = {'node', root_dir .. '/node_modules/@salesforce/soql-language-server/lib/server.js', '--stdio'},
        cmd_env = npm.env(root_dir),
        filetypes = { 'soql' }
    },
}
servers.register(soql_server)
