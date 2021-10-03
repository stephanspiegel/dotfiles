scriptencoding utf-8

" Add nvim config directory to runtimepath
set runtimepath^=$HOME/.config/nvim/config

runtime! /config/*.vim

set autowrite
set wrapscan
set wildignore+=*/.git/*,*/tmp/*,*.swp,*cls-meta.xml
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set linebreak
set breakindent
set visualbell                                          " no sounds

" Open new splits to right and bottom
set splitbelow
set splitright

" Search behavior
" Ignore case when searching
set ignorecase
" Except when the search query contains a capital letter
set smartcase

" Highlight column 120 to keep lines short(er)
set colorcolumn=120

" Invisible characters
set listchars=trail:·,space:·,nbsp:␣,precedes:«,extends:»,eol:↲,tab:▸\
set showbreak=↪\

set noshowmode      " we show the mode in light-line, so don't show again
set showtabline=2   " always show tabline

" Use new diff options
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

set undofile
" 24-bit RGB support in the terminal
set termguicolors 

let g:session_autoload = 'no'

let g:netrw_browsex_viewer= "xdg-open"

" nvim-dap configuration for osv lua debugging
" TODO: Figure out a better place for this <11-09-21, stephan.spiegel> "
lua << END
local dap = require"dap"
dap.configurations.lua = { 
  { 
    type = 'nlua', 
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end


END

nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <F12> :lua require'dap'.step_out()<cr>
nnoremap <F11> :lua require'dap'.step_into()<cr>
nnoremap <F10> :lua require'dap'.step_over()<cr>
nnoremap <leader>ds :lua require'dap'.stop()<cr>
nnoremap <leader>dn :lua require'dap'.continue()<cr>
nnoremap <leader>dk :lua require'dap'.up()<cr>
nnoremap <leader>dj :lua require'dap'.down()<cr>
nnoremap <leader>d_ :lua require'dap'.run_last()<cr>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<cr><C-w>l
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<cr>
vnoremap <leader>di :lua require'dap.ui.variables'.hover()<cr>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.sidebar(widgets.scopes).open()<cr>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<cr>
