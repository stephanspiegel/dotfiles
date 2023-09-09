local maputil = require('stephanspiegel.maputil')
local kraftwerk = require('kraftwerk')

maputil.nmap_all(
  {
    {'gqq', 'vap:ForceDataSoqlQuery csv<CR>'},
    {'gee', 'vap:ForceApexExecute<CR>'}
  }
)
maputil.vmap_all(
  {
    {'gqq', ":'<,'>ForceDataSoqlQuery csv<CR>"},
    {'gee', ":'<,'>ForceApexExecute<CR>"}
  }
)

kraftwerk.setup()
