local maputil = require"stephanspiegel.maputil"

--Remap space as leader key
maputil.map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
maputil.nmap_all
{ {"<Leader>bg", ':let &background = ( &background == "dark"? "light" : "dark")<CR>'}              -- Toggle light/dark color theme
    -- Easy split navigation
, {"<C-j>", "<C-w>j"}
, {"<C-k>", "<C-w>k"}
, {"<C-h>", "<C-w>h"}
, {"<C-l>", "<C-w>l"}
, {"<Leader><CR>", ":nohlsearch<CR>"} -- Hide search highlights with <leader><cr>
, {",cs" ,':let @+=expand("%")<CR>'} -- Copy short file name to clipboard
, {",cl" ,':let @+=expand("%:p")<CR>'} -- Copy long file name to clipboard
, {",ct" ,':let @+=expand("%:t")<CR>'} -- Copy file name without path to clipboard
    -- Resize with arrows
, {"<C-Up>", ":resize +2<CR>"}
, {"<C-Down>", ":resize -2<CR>"}
, {"<C-Left>", ":vertical resize -2<CR>"}
, {"<C-Right>", ":vertical resize +2<CR>"}
}

-- Insert --
maputil.imap_all
{ {"jk", "<ESC>"}
-- Uppercase in insert mode
, {"<C-u>", "<ESC>viwUea"}
}

-- Visual --
maputil.vmap_all
{ {"<", "<gv"} -- Stay in visual mode when indenting
, {">", ">gv"}
}

-- Terminal --
maputil.tmap_all
{ {"<C-h>", "<C-\\><C-N><C-w>h"} -- Better terminal navigation
, {"<C-j>", "<C-\\><C-N><C-w>j"}
, {"<C-k>", "<C-\\><C-N><C-w>k"}
, {"<C-l>", "<C-\\><C-N><C-w>l"}
, {"<C-Up>", "<cmd>resize -2<CR>"}
, {"<C-Down>", "<cmd>resize +2<CR>"}
, {"<C-Left>", "<cmd>vertical resize -2<CR>"}
, {"<C-Right>", "<cmd>vertical resize +2<CR>"}
}
