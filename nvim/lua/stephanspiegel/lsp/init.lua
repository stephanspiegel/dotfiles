local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("stephanspiegel.lsp.lsp-installer")
require("stephanspiegel.lsp.handlers").setup()
require('stephanspiegel.lsp.soql-lsp')
require('stephanspiegel.lsp.apex-lsp')
require('stephanspiegel.lsp.lwc-lsp')
