" Author: Stephan Spiegel <stephan@stephanspiegel.com>
" Description: PMD for Apex files

function! ale_linters#apexcode#pmd#Handle(buffer, lines) abort
    let l:pattern = '"\(\d\+\)",".*","\(.\+\)","\(\d\+\)","\(\d\+\)","\(.\+\)","\(.\+\)","\(.\+\)"$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'type': 'W',
        \   'lnum': l:match[4] + 0,
        \   'text': l:match[5],
        \   'code': l:match[6] . ' - ' . l:match[7],
        \})
    endfor

    return l:output
endfunction

function! plugin#ale_apex_pmd#GetCommand(buffer) abort
    return 'pmd '
    \ . ale#Var(a:buffer, 'apex_pmd_options')
    \ . ' -f csv'
    \ . ' -d %t'
endfunction

if !exists('g:ale_apex_pmd_options')
    let g:ale_apex_pmd_options = 'pmd -R rulesets/apex/ruleset.xml'
endif

call ale#linter#Define('apex', {
\   'name': 'pmd',
\   'executable': 'pmd',
\   'command': function('ale_linters#apex#pmd#GetCommand'),
\   'callback': 'ale_linters#apex#pmd#Handle',
\})
