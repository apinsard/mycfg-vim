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


" {{{ Miscellaneous
"set modeline " /!\ Known vulnerabilities and exploits
set ignorecase
set smartcase
set incsearch

inoremap <C-X><C-V> <ESC>:set paste<CR>"+p<ESC>:set nopaste<CR>i

" Pathogen
exe pathogen#infect()

" Vim projects
if filereadable(".project.vim")
    source .project.vim
endif

" }}}
