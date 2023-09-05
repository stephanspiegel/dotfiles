local maputil = require"stephanspiegel.maputil"

--Remap space as leader key
maputil.map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--What to use to "open" something (we need this below for `gx`)
local opener = ""
if vim.fn.has("mac") == 1 then
    opener = "open"
elseif vim.fn.has("unix") == 1 then
    opener = "xdg-open"
else
    vim.notify("gx is not supported on this OS!", "error")
end

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
, {"<Leader>e", ":Lexplore 30<CR>"} -- Open file explorer
    -- Resize with arrows
, {"<C-Up>", ":resize +2<CR>"}
, {"<C-Down>", ":resize -2<CR>"}
, {"<C-Left>", ":vertical resize -2<CR>"}
, {"<C-Right>", ":vertical resize +2<CR>"}
, {"gx",  '<Cmd>call jobstart(["'..opener..'", expand("<cfile>")], {"detach": v:true})<CR>'}
}

-- Insert --
maputil.imap_all
{ {"jk", "<ESC>"}
-- Uppercase in insert mode
, {"<C-u>", "<ESC>viwUea"}
}

-- Visual --
maputil.vmap_all
{ {"<", "<gv"} -- Stay in indent mode
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
