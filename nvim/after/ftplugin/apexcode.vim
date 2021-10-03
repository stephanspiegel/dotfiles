autocmd BufRead,BufNewFile * set path+=**/*/classes/,**/*/triggers/
autocmd BufRead,BufNewFile * setlocal suffixesadd+=.cls,.trigger
autocmd BufRead,BufNewFile * setlocal shiftwidth=4
autocmd BufRead,BufNewFile * setlocal tabstop=4
autocmd BufRead,BufNewFile * setlocal softtabstop=4
autocmd BufRead,BufNewFile * setlocal expandtab
autocmd BufRead,BufNewFIle * setlocal autoindent
autocmd BufRead,BufNewFIle * setlocal cindent
