function ShowHarpoonMenu()
  local marks = require("harpoon").get_mark_config().marks
  -- Default entries, that are always shown
  local menuEntries = {
    { "Show all", ':lua require("harpoon.ui").toggle_quick_menu()' },
    { "Add current File", ':lua require("harpoon.mark").add_file()' },
  }
  -- Add divider if we have marks
  if #marks > 0 then
    table.insert(
      menuEntries,
      { "────────────────────────────" }
    )
  end

  -- Prepare navigation marks
  for i, v in ipairs(marks) do
    -- Get just the filename from entire path
    local file = string.match("/" .. v.filename, ".*/(.*)$")
    -- Add menu entry
    table.insert(menuEntries, { i .. " " .. file, "lua require('harpoon.ui').nav_file(" .. i .. ")" })
  end
  -- Show menu
  require("conmenu").openCustom(menuEntries)
end

vim.g["conmenu#default_menu"] = {
  {
    "  Navigate",
    {
      { "  Fuzzy", ":lua require('telescope.builtin').find_files({no_ignore=true, hidden=true})" },
      { "  Recent Files", ":lua require('telescope.builtin').oldfiles()" },
      { "  Marks", ":lua require('telescope.builtin').marks()" },
      { "────────────────────────────" },
      { "﬍  Explorer", ":NvimTreeToggle" },
      { "﬍  Reveal in Explorer", ":NvimTreeFindFile" },
      { "  Toggle outline", ":Vista!!" },
    },
  },
  {
    "﬘  Buffers",
    {
      { "﬘  Show All", ":lua require('telescope.builtin').buffers()" },
      { "﬘  Recent Here", ":lua require('telescope.builtin').oldfiles({only_cwd=true})" },
      { "﬘  Recent All", ":lua require('telescope.builtin').oldfiles()" },
    },
  },
  {
    "  Git",
    {
      { "Status", ":Git" },
      { "Blame", ":Git blame" },
      { "Why", ":lua require('gitsigns').blame_line({full=true, ignore_whitespace=true})" },
      { "────────────────────────────" },
      { "Create Worktree", ":lua require('conmenu').createWorktree()" },
      { "Select Worktree", ":lua require('conmenu').selectWorktree()" },
      { "Remove Worktree", ":lua require('conmenu').removeWorktree()" },
    },
    { filter = "IsInGitWorktree" },
  },
  { "  Harpoon", ":lua ShowHarpoonMenu()" },
}
--[[
vim.g["conmenu#default_menu"] = {
  {
    "  Code Actions",
    {
      { "  Rename", ":call CocActionAsync('rename')" },
      { "  Fix", ":CocFix" },
      { "  Cursor", ":call CocActionAsync('codeAction', 'cursor')" },
      { "  Refactor", ":call CocActionAsync('refactor')" },
      { "  Selection", "execute 'normal gv' | call CocActionAsync('codeAction', visualmode())" },
      { "  Definition", ":call CocActionAsync('jumpDefinition')" },
      { "  Declaration", ":call CocActionAsync('jumpDeclaration')" },
      { "  Type Definition", ":call CocActionAsync('jumpTypeDefinition')" },
      { "  Implementation", ":call CocActionAsync('jumpImplementation')" },
      { "  References", ":call CocActionAsync('jumpReferences')" },
      { "  Usages", ":call CocActionAsync('jumpUsed')" },
      { "  Test Nearest", ":TestNearest" },
      { "﬍  File Outline", ":CocOutline" },
      { "   Format File", ":PrettierAsync" },
      { "   UnMinify JS", ":call UnMinify()" },
      { "   Organise Imports", ":call CocAction('organizeImport')" },
    },
    { onlyTypes = javascriptTypes },
  },
  {
    "  Code Diagnostics",
    {
      { "  List Diagnostics", ":CocList diagnostics" },
      { "  Previous", ":call CocActionAsync('diagnosticPrevious')" },
      { "  Next", ":call CocActionAsync('diagnosticNext')" },
      { "  Info", ":call CocActionAsync('diagnosticInfo')" },
    },
    { onlyTypes = javascriptTypes },
  },
  { "  Scripts", ":lua require('conmenu').fromNpm()", { filter = "IsInNodeProject" } },
  {
    "────────────────────────────",
    nil,
    { onlyTypes = javascriptTypes },
  },
  {
    "  Navigate",
    {
      { "  Fuzzy", ":Files" },
      { "  Recent Files", ":CtrlPMRUFiles" },
      { "  Mixed", ":CtrlPMixed" },
      { "  Marks", ":Marks" },
      { "────────────────────────────" },
      { "﬍  Explorer", ":CocCommand explorer" },
      { "﬍  Highlight in Explorer", ":CocCommand explorer --reveal" },
      { "  Lines in file", ":CocList outline" },
    },
  },
  {
    "  Utils",
    {
      { "  Git", ':call ToggleTerm("lazygit")',
        { filter = "IsInGitWorktree" }
      },
      { "  Docker", ':call ToggleTerm("lazydocker")' },
      { "  Databases", ":DBUI" },
      { "  Terminal", ":terminal" },
      { "  Dev Docs", ":call devdocs#open(expand('<cword>'))" },
      { "  Help", ":call ShowDocumentation()" },
      { "────────────────────────────" },
      { "  Delete All Marks", ":delmarks A-Z0-9a-z" },
      {
        "  Configs",
        {
          { " neovim", ":e ~/.config/nvim/init.vim" },
          { " zsh", ":e ~/.zshrc" },
          { " coc.nvim", ":CocConfig" },
        },
      },
      { "────────────────────────────" },
      { "  Buffer in Finder", ':silent exec "!open %:p:h"' },
      { "  Project in Finder", ':silent exec "!open $(pwd)"' },
      { "פּ  TreeSitter Playground", ":TSPlaygroundToggle" },
    },
  },
  {
    "﬘  Buffers",
    {
      { "﬘  Show All", ":Buffers" },
      { "﬘  Close All", ":silent bufdo BD!" },
    },
  },
  {
    "  Git",
    {
      { "Status", ":Git" },
      { "Blame", ":Git blame" },
      { "Why", ":GitMessenger" },
      { "────────────────────────────" },
      { "Create Worktree", ":lua require('conmenu').createWorktree()" },
      { "Select Worktree", ":lua require('conmenu').selectWorktree()" },
      { "Remove Worktree", ":lua require('conmenu').removeWorktree()" },
    },
    { filter = "IsInGitWorktree" },
  },
  { "  Harpoon", ":lua ShowHarpoonMenu()" },
} 
]]
