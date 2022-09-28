local lspconfig = require 'lspconfig'
local server = require 'nvim-lsp-installer.server'
local servers = require 'nvim-lsp-installer.servers'
local npm = require 'nvim-lsp-installer.core.managers.npm'
local configs = require 'lspconfig.configs'

local server_name = 'lwc'

configs[server_name] = {
    default_config = {
        filetypes = { 'javascript' },
        root_dir = lspconfig.util.root_pattern '.git',
    },
}

local root_dir = server.get_server_root_path(server_name)

local lwc_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    async = true,
    languages = { 'javascript' },
    homepage = 'https://github.com/forcedotcom/lightning-language-server',
    installer = npm.packages { '@salesforce/lwc-language-server' },
    default_options = {
        cmd = {'node', root_dir .. '/node_modules/@salesforce/lwc-language-server/lib/server.js', '--stdio'},
        cmd_env = npm.env(root_dir),
        filetypes = { 'javascript' }
    },
}
servers.register(lwc_server)
