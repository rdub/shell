set lines=50
set columns=80
colorscheme wombat

"   no toolbar
set guioptions-=T

"   no blinking cursor
set guicursor+=a:blinkon0

" font
set guifont=Monaco:h13
" set nomacatsui

"   remove all default menus
aunmenu *

"   add custom menu options
menu Edit.Paste "*p
menu Output.HTML :runtime! syntax/2html.vim<CR>
menu Output.HTML\ Light :set background=light<CR>:runtime! syntax/2html.vim<CR>:set background=dark<CR>:highlight Normal guifg=gray guibg=black<CR>
menu Output.PS :call Mkps()<CR>
