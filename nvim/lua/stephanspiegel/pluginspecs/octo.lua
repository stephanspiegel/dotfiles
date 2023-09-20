return { -- Edit and review GitHub issues and pull requests
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'devicons',
  },
  cmd = {
    "Octo"
  },
  config = true
}
