return {
  {
    "stephanspiegel/kraftwerk.nvim",
    -- dir = "~/Projects/vim/kraftwerk.nvim",
    dev = false,
    config = true,
    ft = "apexcode",
    keys = {
      {'gqq', 'vap:ForceDataSoqlQuery csv<CR>', mode = 'n', desc = 'Run current paragraph as SOQL query'},
      {'gee', 'vap:ForceApexExecute<CR>', mode = 'n', desc = 'Run current paragraph as Anonymous Apex'},
      {'gqq', ":'<,'>ForceDataSoqlQuery csv<CR>", mode = 'v', desc = 'Run selected text as SOQL query'},
      {'gee', ":'<,'>ForceApexExecute<CR>", mode = 'v', desc = 'Run selected text as Anonymous Apex'}
    }
  }
}
