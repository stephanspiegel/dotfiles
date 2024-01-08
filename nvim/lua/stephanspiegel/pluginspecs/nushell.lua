return {
  "LhKipp/nvim-nu",
  ft = "nu",
  opts = {
    all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
  }
}
