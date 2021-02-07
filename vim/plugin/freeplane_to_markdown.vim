function! Freeplane2Markdown()
    silent set filetype=xml
    silent FormatXML
    silent set filetype=markdown
    silent %v/\<TEXT\>/d
    silent %s/\(\s\)\?<node TEXT="\([^"]*\)".*/\1\2
    silent %s/&quot;/"/g
    silent normal ggI#
    silent %s/^ \{2\}\ze\S/##/
    silent %s/ \{2\}\ze\S/  - /
endfunction

command! FreeplaneToMarkdown :call Freeplane2Markdown()
