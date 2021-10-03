augroup apex 
    autocmd!
    autocmd BufNewFile,BufRead */src/classes/*.cls set filetype=apexcode
    autocmd BufNewFile,BufRead */src/triggers/*.trigger set filetype=apexcode
    autocmd BufNewFile,BufRead */force-app/main/default/classes/*.cls set filetype=apexcode
    autocmd BufNewFile,BufRead */force-app/main/default/triggers/*.trigger set filetype=apexcode
    autocmd BufNewFile,BufRead *.apex set filetype=apexcode
    autocmd BufNewFile,BufRead *.soql set filetype=soql
    autocmd BufNewFile,BufRead *.apexcode set filetype=apexcode
augroup END
