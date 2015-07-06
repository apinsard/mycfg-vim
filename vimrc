" {{{ Look and feel
set background=dark
set nohls

set list
set listchars=tab:▶-,eol:↵,nbsp:▒
highlight NonText ctermfg=0
highlight SpecialKey ctermfg=0

" }}}


" {{{ Tabbing and indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smarttab
set smartindent

filetype plugin on
filetype plugin indent on

" }}}


" {{{ Visual select text between XML tags
nnoremap vi> F>lvf<h

" }}}

" {{{ Remove extra whitespaces
com -nargs=0 -range=% RemoveExtraWhitespaces <line1>,<line2>s/\s\+$//

" }}}


" {{{ Miscellaneous
"set modeline " /!\ Known vulnerabilities and exploits
set ignorecase
set smartcase
set incsearch

inoremap <C-X><C-V> <ESC>:set paste<CR>"+p<ESC>:set nopaste<CR>i

" Pathogen
exe pathogen#infect()

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Vim projects
if filereadable(".project.vim")
    source .project.vim
endif

" }}}

" {{{ Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

" }}}
