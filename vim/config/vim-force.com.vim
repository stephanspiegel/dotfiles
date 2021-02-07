if has('gui_macvim')
    let &runtimepath=&runtimepath . ',~/.vim/bundle/vim-force.com'
    let g:apex_tooling_force_dot_com_path='/Users/sspiegel/tooling-force.com/tooling-force.com-assembly-v0.4.2.0.jar'
    let g:apex_properties_folder='/Users/sspiegel/apex-properties'
    let g:apex_backup_folder='/tmp/apex/backup'
    let g:apex_temp_folder='/tmp/apex/temp'
    let g:apex_workspace_path="/Users/sspiegel/Projects/"
elseif has('unix')
    let &runtimepath=&runtimepath . ',~/.vim/bundle/vim-force.com'
    let g:apex_tooling_force_dot_com_path='/home/stephan/tooling-force.com/tooling-force.com-assembly-v0.4.2.0.jar'
    let g:apex_properties_folder='/home/stephan/apex-properties'
    let g:apex_backup_folder='/tmp/apex/backup'
    let g:apex_temp_folder='/tmp/apex/temp'
    let g:apex_workspace_path="/home/stephan/Projects/"
elseif has("win32")
    " let g:apex_java_cmd = '$HOMEPATH\\scoop\\apps\\openjdk13\\current\\bin\\java.exe'
    let &runtimepath=&runtimepath . '$HOMEPATH\\vimfiles\\bundle\\vim-force.com'
    let g:apex_tooling_force_dot_com_path=expand('$HOMEPATH') . '\\tools\\vim-force.com\\tooling-force.com-0.4.7.0.jar'
    let g:apex_properties_folder=expand('$HOMEPATH') . '\\apex-properties'
    let g:apex_backup_folder=expand('$HOMEPATH') . '\\tools\\vim-force.com\\backup'
    let g:apex_temp_folder=expand('$HOMEPATH') . '\\tools\\vim-force.com\\temp'
    let g:apex_workspace_path=expand('$HOMEPATH') . '\\Projects\\Salesforce'
endif
autocmd FileType apexcode nnoremap <buffer> <C-]> :call apexComplete#goToSymbol()<Enter>
let g:apex_server_timeoutSec=60*30 " allow server to wait for new connections within 30 minutes
let g:apex_API_version = 47.0

function! s:setApexShortcuts()

    """"""""""""""""""""""""""""""""""""""""""
    " Search in files
    """"""""""""""""""""""""""""""""""""""""""

    " search exact word
    nmap <leader>sc :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.cls ../**/*.trigger <CR>:cwin<CR>
    nmap <leader>st :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.trigger <CR>:cwin<CR>
    nmap <leader>sp :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.page <CR>:cwin<CR>
    nmap <leader>ss :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.scf <CR>:cwin<CR>
    nmap <leader>sa :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.cls ../**/*.trigger ../**/*.page ../**/*.scf <CR>:cwin<CR>

    " search - *contains* - partal match is allowed
    nmap <leader>sC :noautocmd vimgrep /<C-R><C-W>/j ../**/*.cls ../**/*.trigger <CR>:cwin<CR>
    nmap <leader>sT :noautocmd vimgrep /<C-R><C-W>/j ../**/*.trigger <CR>:cwin<CR>
    nmap <leader>sP :noautocmd vimgrep /<C-R><C-W>/j ../**/*.page <CR>:cwin<CR>
    nmap <leader>sS :noautocmd vimgrep /<C-R><C-W>/j ../**/*.scf <CR>:cwin<CR>
    nmap <leader>sA :noautocmd vimgrep /<C-R><C-W>/j ../**/*.cls ../**/*.trigger ../**/*.page ../**/*.scf <CR>:cwin<CR>

    " prepare search string, but do not run
    nmap <leader>sm :noautocmd vimgrep /\<<C-R><C-W>\>/j ../**/*.cls ../**/*.trigger ../**/*.page ../**/*.scf \|cwin

    " search visual selection in Apex project
    function! ApexFindVisualSelection(searchType) range
        let l:apex_search_patterns = {'class': '../**/*.cls ../**/*.trigger',
                    \'trigger': '../**/*.trigger',
                    \'page': '../**/*.page',
                    \'all': '../**/*.cls ../**/*.trigger ../**/*.page ../**/*.scf'}
        let l:saved_reg = @"
        execute 'normal! vgvy'

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", '', '')

        let commandLine='noautocmd vimgrep ' . '/'. l:pattern . '/j '

        let commandLine = commandLine . l:apex_search_patterns[a:searchType]
        "echo "commandLine=" . commandLine
        execute commandLine
        execute 'cwin'

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction
    vmap <leader>sc :call ApexFindVisualSelection('class')<CR>
    vmap <leader>st :call ApexFindVisualSelection('trigger')<CR>
    vmap <leader>sp :call ApexFindVisualSelection('page')<CR>
    vmap <leader>sa :call ApexFindVisualSelection('all')<CR>


    """"""""""""""""""""""""""""""""""""""""""
    " CTags shortcuts
    """"""""""""""""""""""""""""""""""""""""""
    " shortcut to update ctags DB manually
    " note for XFCE: disable default workspace 11 switch (Ctrl-F11) shortcut
    " (settings-> Window Manager -> Keyboard),
    " otherwise C-F11 in vim does not work
    map <C-F11> <Esc>:ApexUpdateCtags<CR>

endfunction

" load shortcut mapping when one of apexcode file types is detected/loaded
autocmd FileType apexcode.java call s:setApexShortcuts()
autocmd FileType apexcode.html call s:setApexShortcuts()
autocmd FileType apexcode.javascript call s:setApexShortcuts()
autocmd FileType apexcode.html call s:setApexShortcuts()

autocmd FileType apexcode iabbrev <buffer> select SELECT
autocmd FileType apexcode iabbrev <buffer> from FROM
autocmd FileType apexcode iabbrev <buffer> where WHERE
autocmd FileType apexcode iabbrev <buffer> and AND
autocmd FileType apexcode iabbrev <buffer> limit LIMIT

function! s:RunApexTests()
    let testMethod = expand("<cword>")
    if testMethod != ""
        let testMethod = ("." . testMethod)
    endif
    exec "ApexTest tooling-sync " . expand("%:t:r") . testMethod
endfunction
command! ApexTestThis call s:RunApexTests()

runtime ftdetect/vim-force.com.vim
