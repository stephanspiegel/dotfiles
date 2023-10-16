
-- ╭──────────────────────────────────────────────────────────╮
-- │                         Diagrams                         │
-- ╰──────────────────────────────────────────────────────────╯
return {
  {
    "willchao612/vim-diagon", -- Simple Unicode or ASCII diagrams
    config = function()
      vim.g.diagon_use_echo = 1 --- Use echo instead of replacing original text directly
    end,
    cmd = "Diagon"
  },
  {
    "LudoPinelli/comment-box.nvim", -- Draw boxes around comments
    cmd = {
      "CBllbox",
      "CBlcbox",
      "CBlrbox",
      "CBclbox",
      "CBccbox",
      "CBcrbox",
      "CBrlbox",
      "CBrcbox",
      "CBrrbox",
      "CBalbox",
      "CBacbox",
      "CBarbox",
    }
  },
  {
    "dhruvasagar/vim-table-mode",
    cmd = {
      "TableModeToggle",
      "TableModeEnable",
      "TableModeDisable",
      "Tableize",
      "TableModeRealign",
      "TableAddFormula",
      "TableEvalFormulaLine",
      "TableSort",
    }
  }
}

