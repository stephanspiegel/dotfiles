" Escape/Unescape HTML
function! HtmlEscape()
  silent %s/&/\&amp;/eg
  silent %s/</\&lt;/eg
  silent %s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
  silent %s/&lt;/</eg
  silent %s/&gt;/>/eg
  silent %s/&amp;/\&/eg
  silent %s/&apos;/'/eg
  silent %s/&quot;/"/eg

endfunction

command! EscapeHTML call HtmlEscape()
command! UnescapeHTML call HtmlUnEscape()
