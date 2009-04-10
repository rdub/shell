" Vimrc - 
" Originally by Justin Rocha <xenith@xenith.org>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ****************
" Personal Options

set autoindent
set smartindent
set term=xterm-color    " Makes mouse work in Eterm
set ttyfast
set background=light
set tabstop=4           " TAB == 4 spaces
set shiftwidth=4        " TAB == 4 spaces
set softtabstop=4       " TAB == 4 spaces
set showmatch		    " show matching braces
set showmode
set showcmd             " show current uncompleted command
set wildmode=full
set ls=2                " Show the name of buffers
set foldmethod=indent
set foldlevel=1000
set laststatus=2
set guioptions-=T
set backspace=2         " Allow backspacing over everything
set ai                  " Always set autoindenting on
set nobackup            " Never keep a backup file
set autowrite
set report=0		    " Report all changed lines
set history=50		    " keep 50 lines of command line history
set pastetoggle=<F12>


" *********
" MODELINES

set modelines=10


" *************
" ABBREVIATIONS

iab NMEML <C-R>=strftime("%x")<CR>  Ryan Du Bois <rdub@apple.com>
iab DATE <C-R>=strftime("%x")<CR>
iab TIME <C-R>=strftime("%T")<CR>
iab FULLDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>

" ****
" MAPS

" Don't use Ex mode, use Q for formatting
map Q gq

" Quicker dictionary lookup and filecompletion
imap <C-G> <C-X><C-K>
imap <C-F> <C-X><C-F>

" Fix weird error that just occured :/
imap  <BS>

" Forgot to release the SHIFT key
nmap :W :w
nmap :Q :q
nmap :WQ :wq
nmap :Wq :wq
nmap :wQ :wq

" Backspace works in normal mode
nmap <BS> hx

" Rot13
vmap rot g?

" C type language specific maps
function! C_maps()
	map!	'if	if () {o}keei
	map!	'for	for () {o}keei
	map!	'while	while () {o}keei
	map!	'inc	#include <.h>hhi
	map!	'def	#define a
	map!	'main	int main(int argc, char **argv)o{o}ki
endfu

" Matching brackets and quotes
"inoremap { {}<ESC>i
"inoremap ( ()<ESC>i
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i

imap BOX1 ,------[]<CR><CR>`------[]<UP>\| 
imap BOX2 /~~~~~~~~~~~~~~~~~~~`--------*<CR><CR>\________,-------*<UP>\| 



" ********
" COMMANDS

" Convert the current buffer into html complete with syntax highlighting
com HTML :so \$VIMRUNTIME/syntax/2html.vim


" *********
" TERMINALS

if $COLORTERM == "Eterm"
	" Blah blah
endif

" ******
" SYNTAX

if has("syntax")

	" ************************************
	" LANGUAGE SPECIFIC HIGHLIGHT SETTINGS

	" * C *
	" Highlighting strings inside comments
	let c_comment_strings=1
	" Bad spaces. Bad.
	"let c_space_errors=1

	" * PHP *
	" syntax highlighting of sql queries (might be annoying)
	let php3_sql_query=1
	let phtml_sql_query=1
	let php3_minlines = 600
	let php_sql_query=1
	let php_minlines = 600

	" * Python *
	let python_highlight_all = 1

	" * SHELL *
	"let bash_is_c = 1
	let bash_is_sh=1

	" ***********
	" START'ER UP

	syntax on

	set hlsearch
	set incsearch


	"*********************
	" OVERRIDE SOME COLORS

	hi! Comment  ctermfg=DarkCyan guifg=DarkCyan
	hi! PreProc  term=underline ctermfg=Cyan guifg=Cyan
	hi! Constant term=underline ctermfg=LightRed guifg=Brown

endif


if has("folding")
	"set foldcolumn=2
endif


"if has("mouse")
"	set mouse=a
"	set mousehide
"endif


if has("statusline")
	" Format the statusline
	hi statusline   term=NONE cterm=NONE ctermfg=White ctermbg=Blue
	set statusline=%-30.30(%F%m%r%)\ Type:\ %Y\ Buf:\ %n%=%l,%c%V\ %P
else
	set ruler		" show the cursor position all the time
endif


if has("viminfo")
	" remember informations from previous Vim sessions
	" '20 -> marks for last 20 files are saved
	" no `f<value>' -> all marks are saved
	" "50 -> max lines for each register
	" no `:' -> 'history' items of cmd-line are saved
	" no `/' -> 'history' items of search-pattern-history are saved
	" `h' -> disable effect of 'hlsearch'
	" no `@' -> 'history' items of input-line history are saved
	" `%' -> buffer list is saved and restored if Vim is called w/o args

	set viminfo='50,\"200,h,%
endif


if has("autocmd")
	"autocmd!

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent
	" indenting.
	"filetype plugin indent on

    au BufRead,BufNewFile Makefile*
        \ set ts=4 sw=4 noexpandtab tw=0

	au FileType	html,css
		\   set tabstop=4 shiftwidth=4

   au FileType     php
      \   set tabstop=4 shiftwidth=4
		\ | set expandtab
		\ | call C_maps()

	" Mail
	au FileType	mail	set expandtab

	" Perl
	au BufNewFile	*.pl
		\   s,^,#!/usr/bin/perl -w,
		\ | w
		\ | r !chmod +x % > /dev/null

	au FileType	perl	set kp=perldoc\ -f

	" Python
	au BufNewFile	*.py
		\   s,^,#!/usr/bin/env python,
		\ | w
		\ | r !chmod +x % > /dev/null

	au FileType	python
		\   set tabstop=2 shiftwidth=2
		\ | set expandtab

	" Shell
	au BufNewFile	*.sh
		\   s,^,#!/bin/sh,
		\ | w
		\ | r !chmod +x % > /dev/null

	" C, C++, JavaScript, Java
	au FileType	c,cpp,javascript,java
		\   set tabstop=4
		\ | set shiftwidth=4
        \ | set softtabstop=4
		\ | call C_maps()


	" Restore position in file if previously edited (uses viminfo)
	au BufReadPost	*
		\   if line("'\"") > 0 && line("'\"") <= line("$")
		\ |	exe "normal g'\""
		\ | endif

endif " has("autocmd")

"rot13 dmca-grade encryption
"this is useful to obfuscate whatever it is that you're working on temporarily
"if someone walks by (vim pr0n?)
map <F3> mzggVGg?`z

"don't expand tabs if we're in a makefile
au BufRead,BufNewFile Makefile set ts=4 sw=4 noexpandtab
"wrap lines in TeX
au BufRead,BufNewFile *.tex set tw=80
"wrap lines in .txt files
autocmd BufNewFile,BufRead *.txt set tw=78

set background=dark     "awesome for terminals with crappy colors (putty!)
set foldmethod=manual   "enable code folding

"colorscheme evening

map <C-M> mvggVG:s/<C-V><CR>//g<CR>`v

" Source cscope integration
source ~/.shell/cscope_maps.vim
