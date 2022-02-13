local lspconfig = require 'lspconfig'
local server = require 'nvim-lsp-installer.server'
local servers = require 'nvim-lsp-installer.servers'
local configs = require 'lspconfig.configs'
local std = require 'nvim-lsp-installer.installers.std'
local context = require 'nvim-lsp-installer.installers.context'

local server_name = 'apex'

configs[server_name] = {
    default_config = {
        filetypes = { 'apexcode', 'apex', 'apex-anon' },
        root_dir = lspconfig.util.root_pattern('sfx-project.json', '.git'),
    },
}

local root_dir = server.get_server_root_path(server_name)
print ('root_dir (apex): '..root_dir)

local apex_server = server.Server:new {
  name = server_name,
  root_dir = root_dir,
  languages = { 'apex' },
  homepage = 'https://developer.salesforce.com/tools/vscode/en/apex/language-server',
  installer = {
    std.ensure_executables {
    { 'java', 'java was not found in path.' },
    },
    std.download_file('https://github.com/forcedotcom/salesforcedx-vscode/blob/develop/packages/salesforcedx-vscode-apex/out/apex-jorje-lsp.jar?raw=true', 
      'apex-jorje-lsp.jar'),
  },
  default_options = {
      cmd = { 
        'java',
        '-cp',
        root_dir .. '/apex-jorje-lsp.jar',
        '-Ddebug.internal.errors=true',
        '-Ddebug.semantic.errors=true',
        '-Ddebug.completion.statistics=true',
        '-Dlwc.typegeneration.disabled=true',
        'apex.jorje.lsp.ApexLanguageServerLauncher'
      },
      filetypes = { 'apex', 'apexcode', 'apex-anon' }, 
      trace = 'verbose'
  }
}
servers.register(apex_server)
