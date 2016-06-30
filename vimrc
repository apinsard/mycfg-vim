" {{{ Look and feel
set background=dark
set nohls

set list
set listchars=tab:▶-,eol:↵,nbsp:▒,trail:.
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


" {{{ Remove extra whitespaces
com -nargs=0 -range=% RemoveExtraWhitespaces <line1>,<line2>s/\s\+$//

" }}}

" {{{ Status Line
set statusline=%5(%3m%2n%)\ 〉
set statusline+=%.30f
set statusline+=%=
set statusline+=%(\ [%Y]%)
set statusline+=\ <%v,%l,0x%B>
set statusline+=\ [%p%%]


" }}}


" {{{ Miscellaneous
set modeline
set ignorecase
set smartcase
set incsearch

" Save as root
cnoremap w!! w !sudo tee > /dev/null %

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
