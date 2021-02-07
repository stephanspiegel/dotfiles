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
" all buffers
:nnoremap <F5> :buffers<CR>:buffer<Space>
" unsaved buffers
:nnoremap <S-F5> :buffers +<CR>:buffer<Space>

" Coc-explorer
:nmap <space>e :CocCommand explorer<CR>

" Uppercase in insert mode
inoremap <c-u> <esc>viwUea

" Fugitive conflict resolution
nnoremap gdt :diffget //2<CR>
nnoremap gdm :diffget //3<CR>

" FZF mappings
nnoremap <D-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GitFiles<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>h :History<CR>
