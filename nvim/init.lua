local namespace = 'stephanspiegel.'

local modules =
{ 'options'
, 'mappings'
, 'plugins'
, 'colorscheme'
, 'completion'
, 'lsp'
, 'title'
}

for _, module in ipairs(modules) do
   require(namespace..module)
end
