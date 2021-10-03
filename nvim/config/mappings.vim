let mapleader = ' '

inoremap jk <ESC>

" edit .vimrc
:nnoremap <leader>ev :tabe $MYVIMRC<cr>

" Toggle light/dark color theme
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark")<CR>

" F7 to toggle tag bar
nmap <F7> :TagbarToggle<CR>

" Easy split navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Hide search highlights with <leader><cr>
map <silent> <leader><cr> :nohlsearch<cr>

" Show buffer selection on F5
nnoremap <F5> :buffers<CR>:buffer<Space>

"Copy file name to clipboard
if has('win32')
    " Convert slashes to backslashes for Windows.
    nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
    nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
    nmap ,ct :let @*=substitute(expand("%:t"), "/", "\\", "g")<CR>
      " This will copy the path in 8.3 short format, for DOS and Windows 9x
    nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
    nmap ,cs :let @*=expand("%")<CR>
    nmap ,cl :let @*=expand("%:p")<CR>
    nmap ,ct :let @*=expand("%:t")<CR>
endif

" Easy buffer switching
" unsaved buffers
:nnoremap <S-F5> :buffers +<CR>:buffer<Space>

" Coc-explorer
:nmap <space>e :CocCommand explorer<CR>

" Uppercase in insert mode
inoremap <c-u> <esc>viwUea

" Fugitive conflict resolution
nnoremap gdt :diffget //2<CR>
nnoremap gdm :diffget //3<CR>

" Telescope mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>c <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>hc <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>hs <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>cs <cmd>lua require('telescope.builtin').colorscheme()<cr>

