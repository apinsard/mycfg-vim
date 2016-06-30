" {{{ Look and feel
set nohls

set list
set listchars=tab:▶-,eol:↵,nbsp:▒,trail:.
" highlight NonText ctermfg=0
" highlight SpecialKey ctermfg=0


let g:color_schemes = ['ubaryd', 'alduin']

function! SetColorScheme(id)
  let g:color_scheme = a:id % len(g:color_schemes)
  exe "colors " . g:color_schemes[g:color_scheme]
endfunction

function! GetColorScheme()
  return g:color_schemes[g:color_scheme]
endfunction

function! CycleColorScheme()
  call SetColorScheme(g:color_scheme + 1)
  echom "Switch color scheme: " . g:color_schemes[g:color_scheme]
endfunction

nnoremap <F2> :call CycleColorScheme()<CR>

call SetColorScheme(0)

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


" {{{ Status Line
set statusline=%5(%3m%2n%)\ 〉%<
set statusline+=%(%f\ %r%)
set statusline+=%=
set statusline+=%(\ [%{&ft}]%)
set statusline+=%(\ %3l,%3v%)
set statusline+=\ %3p%%

" }}}


" {{{ Remove extra whitespaces
com -nargs=0 -range=% RemoveExtraWhitespaces <line1>,<line2>s/\s\+$//

" }}}


" {{{ Miscellaneous
set modeline    " Set vim settings from file comments (modeline)
set ignorecase  " Required for smartcase below
set smartcase   " Case insensitive search if lowercase only
set incsearch   " Live search while typing
set showcmd     " Show current normal sequence
set number      " Show line numbers

" Save as root
cnoremap w!! w !sudo tee > /dev/null %

" Pathogen
exe pathogen#infect()

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" }}}


" {{{ Load local settings if any

" Local
if filereadable("~/.config/nvim/local.vim")
  source ~/.config/nvim/local.vim
endif

" Vim projects
if filereadable(".project.vim")
  source .project.vim
endif

" }}}
