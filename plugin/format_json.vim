" Prettify JSON
function! DoFormatJSON()
  :%!python -m json.tool
endfunction
command! FormatJSON call DoFormatJSON()

