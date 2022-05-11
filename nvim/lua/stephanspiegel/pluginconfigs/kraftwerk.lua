local maputil = require('stephanspiegel.maputil')

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
