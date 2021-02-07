if has('win32')
    set guifont=Inconsolata_NF:h12:W500:cANSI:qDRAFT
    set renderoptions=type:directx
elseif has('gui_macvim')
    set guifont=FiraCode\ Nerd\ Font:h14
else
    set guifont=FiraMono\ Nerd\ Font\ Mono\ 14
endif
set guioptions-=m   "remove menu bar
set guioptions-=T   "remove toolbar
set guioptions-=r   "remove right-hand scroll bar
set guioptions-=L   "remove lef-hand scroll bar
set guioptions-=e   "don't show guitabs
set guioptions-=L   "remove left-hand scroll bar
set lines=999 columns=999
set fillchars=vert:┃ " for vsplits
set fillchars+=fold:· " for folds
set guiheadroom=0  " don't reserve any pixels for gui
if has("gui_macvim")
    macmenu &File.Print key=<nop>
    set macligatures
endif
