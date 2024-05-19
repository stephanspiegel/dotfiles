local namespace = 'stephanspiegel.'

local modules =
{ 'options'
, 'mappings'
, 'commands'
, 'plugins'
, 'title'
}

for _, module in ipairs(modules) do
   require(namespace..module)
end
