"Bootstrap vim-plug if it's not installed yet
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" vim-smoothie: smooth scrolling
Plug 'psliwka/vim-smoothie'

" Doge: document generator
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Groovy: groovy language support
Plug 'vim-scripts/groovy.vim'

" Luaref: Lua language reference
Plug 'wsdjeg/luarefvim' 

" KmonadVim: support for kmonad .kbd config files
Plug 'kmonad/kmonad-vim'
 
" Venn: draw diagrams
Plug 'jbyuki/venn.nvim'

" Nuake: Quake style terminal
Plug 'Lenovsky/nuake'
nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>

" Indentline: show indent levels
Plug 'Yggdroot/indentLine'
let g:indentLine_char = ''
let g:indentLine_fileTypeExclude = ['help']

" Gitgutter: display git diff info
Plug 'airblade/vim-gitgutter'

" Polyglot: Multi-language support
Plug 'sheerun/vim-polyglot'

" CSV: csv support
Plug 'chrisbra/csv.vim'

" FZF: fuzzy finder
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Telescope: neovim fuzzy finder
Plug 'nvim-telescope/telescope.nvim'

" Table Mode: create and manipulate ASCII tables
Plug 'dhruvasagar/vim-table-mode'

" Json language support
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" YAML: YAML support
Plug 'mrk21/yaml-vim'

"CapsLock: software capslock
Plug 'tpope/vim-capslock'

" Pear Tree: A painless, powerful Vim auto-pair plugin.
Plug 'tmsvg/pear-tree'
" enable smart pairs
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0

" Commentary: comment out lines of code
Plug 'tpope/vim-commentary'

" Kommentary: nvim commenting plugin
Plug 'b3nj5m1n/kommentary'

" DirDiff: diff directories in vim
Plug 'will133/vim-dirdiff'

" ZFVimDirDiff: better diff directories in vim
Plug 'ZSaberLv0/ZFVimDirDiff'

" Vim Mkdir: when saving, make any directories that don't yet exist
Plug 'pbrisbin/vim-mkdir'

" Neomake: build automation
Plug 'neomake/neomake'

" Sleuth: Automatically set tabstop
Plug 'tpope/vim-sleuth'

" Vim Vinegar: Simplify netrw
Plug 'tpope/vim-vinegar'

" Rust: rust language support
Plug 'rust-lang/rust.vim'

" Cargo: cargo support for rust projects
Plug 'timonv/vim-cargo'

" vim force: Salesforce support
Plug 'neowit/vim-force.com'
" see \config\vim-force.com.vimrc for configuration

Plug 'tpope/vim-fugitive'

" Twiggy: git branch management
Plug 'sodapopcan/vim-twiggy'

" Diffconflicts: Better git merge conflict handling
Plug 'whiteinge/diffconflicts'

" Rainbow: show matching braces in matching colors
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Colorizer: Show hex color codes in their color
Plug 'norcalli/nvim-colorizer.lua'

" Open Browser: Open URLs in browser
Plug 'tyru/open-browser.vim'

" If it looks like URI, open an URI under cursor.
" Otherwise, search a word under cursor.
nmap gx <Plug>(openbrowser-smart-search)
" If it looks like URI, open selected URI.
" Otherwise, search selected word.
vmap gx <Plug>(openbrowser-smart-search)

" Markdown
 
" MKDX: markdown swiss army knife
Plug 'SidOfc/mkdx', { 'for': 'markdown' }

" Markdown: more markdown support
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Markdown Drawer: simplify navigation
Plug 'Scuilion/markdown-drawer', { 'for': 'markdown' }

" Previm: Preview markdown (and other formats that render to HTML)
Plug 'previm/previm', { 'for': 'markdown' }

" Ale: linter
Plug 'dense-analysis/ale'

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save =1
let g:ale_lint_on_filetype_changed = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEWarning ctermbg=none cterm=underline
let g:ale_apex_pmd_options = 'pmd -R '. expand('$HOME') . '/pmd/rulesets/apex/ruleset.xml'

" Emmet: HTML templating
Plug 'mattn/emmet-vim'

" HTML5-syntax: html5 syntax highlighting
Plug 'othree/html5-syntax.vim'

" HTML5: html5 autocomplete
Plug 'othree/html5.vim'

" Tag List: Display tags
Plug 'vim-scripts/taglist.vim'

" Tag Bar: Display tags
Plug 'majutsushi/tagbar'
" show tags in the order they appear in the source
let g:tagbar_sort = 0
" show tagbar at top
let g:tagbar_vertical = 10
let g:tagbar_left = 1

" Ultisnips: Snippets management
Plug 'sirver/ultisnips'

" Snippets: bunch of snippets for Ultisnips
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsSnippetsDir='~/.vim/config/UltiSnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:snips_author='stephan.spiegel'

" Javascript language support
Plug 'pangloss/vim-javascript'

" JSX: jsx syntax highlighting and indenting
Plug 'mxw/vim-jsx'

" Togglelist: toggle Location and Quickfix lists
Plug 'milkypostman/vim-togglelist'

" RipGrep: faster grep
Plug 'jremmen/vim-ripgrep'

" Surround: surround with quotes, brackets, etc.
Plug 'tpope/vim-surround'

" Support for ledger accounting files
Plug 'ledger/vim-ledger'
let g:ledger_default_commodity = 'USD'
let g:ledger_commodity_before = 0
let g:ledger_commodity_sep = ' '
let g:ledger_decimal_sep = '.'
let g:ledger_date_format = '%Y-%m-%d'
let g:ledger_align_at = 60
let g:ledger_bin = '/usr/bin/ledger'
let g:ledger_main = '~/ledger/personal/main.ledger'
let g:ledger_extra_options = ' --pedantic --explicit --check-payees'
augroup Ledger
  autocmd!
  autocmd FileType ledger nnoremap <silent> <leader>c :call ledger#transaction_state_toggle(line('.'), ' *')<CR>
  autocmd FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
  autocmd FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>
augroup END

" Ledger-x: more ledger support
Plug 'rcaputo/vim-ledger_x'

" Vimoutliner: outlining toold
Plug 'vimoutliner/vimoutliner'

" unimpaired.vim
Plug 'tpope/vim-unimpaired'

" lua debugger
Plug 'jbyuki/one-small-step-for-vimkind'

" debugging client
Plug 'mfussenegger/nvim-dap'

"Vim-node: work with node
Plug 'moll/vim-node'

" Startify: menu on vim startup
Plug 'mhinz/vim-startify'
function! s:list_sessions()
    let sessions = map(split(globpath(g:session_directory, '*.vim'), '\n'), {index, val -> fnamemodify(val, ':t:r')})
    return map(sessions, '{"line": v:val, "cmd": "OpenSession " . v:val}')
endfunction

let g:startify_lists = [
      \ { 'type': function('s:list_sessions'),  'header': ['   Sessions']       },
      \ { 'type': 'commands',                   'header': ['   Commands']       },
      \ { 'type': 'files',                      'header': ['   MRU']            },
      \ { 'type': 'dir',                        'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks',                  'header': ['   Bookmarks']      },
      \ ]

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_directory = '~/.vim/sessions'

" Gundo.vim: Undo tree viewer
Plug 'sjl/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

" Coc: language server support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Coc lsp mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> sgr :sp<CR><Plug>(coc-references)
nmap <silent> vgr :vsp<CR><Plug>(coc-references)

command Reformat :call CocAction('format')

" mapping errors and warnings navigation
nnoremap ]x :call CocAction('diagnosticNext')<CR>
nnoremap [x :call CocAction('diagnosticPrevious')<CR>

" Show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Vim Spotlightify: better search highlighting
Plug 'fcpg/vim-spotlightify'

" VimIndentObject: indentation level as text object
Plug 'michaeljsmith/vim-indent-object'

" Goyo: distraction free writing
Plug 'junegunn/goyo.vim'

" Projectionist: Buffer switching
Plug 'tpope/vim-projectionist'

" Tidal: support tidalcycles music live coding language. This is the
" vim-specific version
Plug 'flupe/vim-tidal'
let g:tidal_target = "terminal"

" Vimwiki: wiki
Plug 'vimwiki/vimwiki'
let main_wiki = {}
let main_wiki.path = '~/Projects/notes/'
let main_wiki.auto_toc = 1
let main_wiki.syntax = 'markdown'
let main_wiki.extension = '.wiki'
let g:vimwiki_list = [main_wiki]
let g:vimwiki_global_ext = 0
let g:markdown_folding = 1

" Vim plugin authoring
""""""""""""""""""""""

" Scriptease: plugin authoring utilities
Plug 'tpope/vim-scriptease'

" Plenary
Plug 'nvim-lua/plenary.nvim'

" Under construction: kraftwerk: Salesforce sfdx support
Plug '~/Projects/vim/kraftwerk.nvim'
  set runtimepath+=%HOME/Projects/vim/kraftwerk.nvim

Plug '~/Projects/vim/kraftwerk-dev-support'
  set runtimepath+=%HOME/Projects/vim/kraftwerk-dev-support

" Appearance
""""""""""""

" Bar Themes
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'sfdxuser', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'sfdxuser': 'sfdx#ShowDefaultUser',
      \   'fullFilePath': 'FilePathForLightLine'
      \ }
    \ }
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'fullFilePath' ] ] }

function! FilePathForLightLine()
  return expand('%:p')
endfunction
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1
" let g:airline_theme='base16'
" let g:airline#extensions#tagbar#enabled = 0
" let g:airline#extensions#ale#enabled = 1
" Theme switcher
Plug 'xolox/vim-colorscheme-switcher'
let g:colorscheme_switcher_keep_background = 1
let g:colorscheme_switcher_exclude_builtins = 1
" All the themes!
Plug 'flazz/vim-colorschemes'

" Themes
Plug 'BarretRen/barret-vimcolor'
Plug 'HenryNewcomer/vim-theme-underflow'
Plug 'KKPMW/distilled-vim'
Plug 'KKPMW/oldbook-vim'
Plug 'abnt713/vim-hashpunk'
Plug 'ajmwagar/vim-deus'
Plug 'altercation/vim-colors-solarized'
Plug 'aonemd/kuroi.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'arzg/vim-oldbook8'
Plug 'dennougorilla/azuki.vim'
Plug 'jnurmine/Zenburn'
Plug 'junegunn/seoul256.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'machakann/vim-colorscheme-tatami'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'nightsense/stellarized'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'sainnhe/forest-night'
Plug 'sainnhe/sonokai'
Plug 'smallwat3r/vim-hashpunk-sw'
Plug 'szorfein/darkest-space'
Plug 'theJian/Mogao'
Plug 'thenewvu/vim-colors-sketching'
Plug 'victorze/foo'
Plug 'wimstefan/vim-artesanal'
Plug 'xstrex/FireCode.vim'
Plug 'yuttie/inkstained-vim'

" Monochrome themes
Plug 'camgunz/amber'
Plug 'https://github.com/pgdouyon/vim-yin-yang'
Plug 'https://github.com/ewilazarus/preto'
Plug 'https://github.com/chriskempson/base16-vim'
Plug 'https://github.com/andreasvc/vim-256noir'
Plug 'https://github.com/davidosomething/vim-colors-meh'
Plug 'https://github.com/pbrisbin/vim-colors-off'
Plug 'https://github.com/Jorengarenar/vim-darkness'
Plug 'https://github.com/owickstrom/vim-colors-paramount'
Plug 'https://gitlab.com/rj-white/vim-colors-paramountblue'
Plug 'https://github.com/nikolvs/vim-sunbather'
Plug 'https://github.com/reedes/vim-colors-pencil'
Plug 'https://github.com/huyvohcmc/atlas.vim'
Plug 'https://github.com/Lokaltog/vim-monotone'
Plug 'https://github.com/fxn/vim-monochrome'
Plug 'https://github.com/robertmeta/nofrils'
Plug 'https://github.com/zaki/zazen'
Plug 'https://github.com/t184256/vim-boring'
Plug 'https://github.com/KKPMW/distilled-vim'
Plug 'https://github.com/axvr/photon.vim'
Plug 'https://git.sr.ht/~romainl/vim-bruin'
Plug 'https://github.com/andreypopp/vim-colors-plain'
Plug 'https://github.com/danishprakash/vim-yami'
Plug 'https://github.com/ajgrf/parchment'
Plug 'https://github.com/jaredgorski/fogbell.vim'
Plug 'https://github.com/LuRsT/austere.vim'
Plug 'https://github.com/hardselius/warlock'
Plug 'https://github.com/cideM/yui'
Plug 'https://github.com/aditya-azad/candle-grey'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'habamax/vim-bronzage'

let g:two_firewatch_italics=1
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

" Devicons: Icons support
" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme tempus_tempest
call neomake#configure#automake('w')

