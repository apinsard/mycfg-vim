" {{{ Look and feel
set nohls

set list
set listchars=tab:▶-,eol:↵,nbsp:▒,trail:.
highlight NonText ctermfg=0
highlight SpecialKey ctermfg=0

function! SetColorScheme(name)
  let g:color_scheme=a:name
  exe "colors " . a:name
endfunction

function! GetColorScheme()
  return g:color_scheme
endfunction

function! CycleColorScheme()
  if g:color_scheme == "ubaryd"
    call SetColorScheme("alduin")
  else
    call SetColorScheme("ubaryd")
  endif
  echom "Switch color scheme: " . g:color_scheme
endfunction

call SetColorScheme("alduin")

nnoremap <F2> :call CycleColorScheme()<CR>

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
set statusline=%5(%3m%2n%)\ 〉
set statusline+=%.30f
set statusline+=%=
set statusline+=%(\ [%{&ft},%{&ff},%{&fenc}]%)
set statusline+=%(\ \ %v,%l,0x%B%)
set statusline+=%(\ \ [%p%%]%)
set statusline+=%(\ \ [%{GetColorScheme()}]%)

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
