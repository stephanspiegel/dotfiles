" Author: Stephan Spiegel <stephan@stephanspiegel.com>
" Description: PMD for Apex files

function! after#plugin#ale_apex_pmd#Handle(buffer, lines) abort
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

function! after#plugin#ale_apex_pmd#GetCommand(buffer) abort
    let l:lintcommand = 'pmd '
    \ . ale#Var(a:buffer, 'apex_pmd_options')
    \ . ' -f csv'
    \ . ' -d %t'
    return l:lintcommand
endfunction

if !exists('g:ale_apex_pmd_options')
    let g:ale_apex_pmd_options = '-R rulesets/apex/ruleset.xml'
endif

call ale#linter#Define('apexcode', {
\   'name': 'pmd',
\   'executable': 'pmd',
\   'command': function('after#plugin#ale_apex_pmd#GetCommand'),
\   'callback': 'after#plugin#ale_apex_pmd#Handle',
\})
