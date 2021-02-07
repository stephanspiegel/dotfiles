CocDisable

" inoremap <buffer> <C-T> 
vnoremap <C-T> "xygvc<C-R>=Taxify(str2float(@x))<CR><ESC>
" inoremap <C-T> <ESC>vT "xygvc<C-R>=Taxify(str2float(@x))<CR>
inoremap <C-T> <ESC>?[0-9.]\+<CR>c//e<CR><C-R>=Taxify(str2float(@"))<CR>

function! Taxify(amount)
    return printf('%.2f', a:amount * 1.055)
endfunction

command! LedgerSort call ledger#ledger#sort()
