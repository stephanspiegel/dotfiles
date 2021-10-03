" Colorizer: Show hex color codes in their color
" https://github.com/norcalli/nvim-colorizer.lua
if ! exists('g:loaded_colorizer')
    finish
endif
lua require'colorizer'.setup()
