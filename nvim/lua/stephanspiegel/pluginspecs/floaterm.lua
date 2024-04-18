return {
  "voldikss/vim-floaterm",
  keys = {
    { "<c-t>", mode = {"n"}, "<cmd>FloatermToggle<cr>"},
    { "<c-t>", mode = {"t"}, [[<C-\><C-n>:FloatermToggle<CR>]]},
    { "<c-\\>", mode = {"n"}, "<cmd>FloatermNew<cr>"},
    { "<c-j>", mode = {"t"}, "<cmd>FloatermNext<cr>"},
    { "<c-k>", mode = {"t"}, "<cmd>FloatermPrev<cr>"},
    { "<c-t>", mode = {"v"}, "<cmd>'<,'>FloatermSend<cr><cmd>FloatermToggle<cr>"},
  },
  config = function()
    -- Make floating windows look like telescope
    vim.cmd([[hi! link FloatermBorder TelescopeBorder]])
    vim.cmd([[hi! link Floaterm TelescopeNormal]])

    -- Make Floatterm use ZSH
    vim.g.floaterm_shell = "zsh"
    -- Make Floatterm look like Telescope
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    -- If Floatterm opens a file, open it in a split
    vim.g.floaterm_opener = "split"

    vim.g.floaterm_height = 0.9
    vim.g.floaterm_width = 0.9
  end,
}
