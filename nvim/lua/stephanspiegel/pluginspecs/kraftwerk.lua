return {
  {
    "stephanspiegel/kraftwerk.nvim",
    -- dir = "~/Projects/vim/kraftwerk.nvim",
    dev = false,
    config = true,
    ft = {  "apexcode", "soql", "apex" },
    keys = {
      {'gqq', 'mxvap:ForceDataSoqlQuery csv<CR>`x', mode = 'n', desc = 'Run current paragraph as SOQL query'},
      {'gee', 'mxvap:ForceApexExecute<CR>`x', mode = 'n', desc = 'Run current paragraph as Anonymous Apex'},
      {'gqq', ":'<,'>ForceDataSoqlQuery csv<CR>gv", mode = 'v', desc = 'Run selected text as SOQL query'},
      {'gee', ":'<,'>ForceApexExecute<CR>gv", mode = 'v', desc = 'Run selected text as Anonymous Apex'}
    }
  }
}
