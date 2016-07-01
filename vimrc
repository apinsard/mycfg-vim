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

function! SetStatusLine(id)
  let g:status_line = a:id % 2
  if g:status_line == 0
    set statusline=%5(%3m%2n%)\ 〉%<
    set statusline+=%(%f\ %r%)
    set statusline+=%=
    set statusline+=%(\ [%{&ft}]%)
    set statusline+=%(\ %3v\ \ %)
  else
    set statusline=%5(%3m%2n%)\ 〉%<
    set statusline+=%(%f\ %r%)
    set statusline+=%=
    set statusline+=%(\ [%{&ft},%{&ff},%{&fenc}]%)
    set statusline+=%(\ %3l,%3v,0x%04B%)
    set statusline+=\ %3p%%
  endif
endfunction

function! CycleStatusLine()
  call SetStatusLine(g:status_line + 1)
endfunction

nnoremap <F3> :call CycleStatusLine()<CR>

call SetStatusLine(0)

" }}}


" {{{ Remove extra whitespaces
com -nargs=0 -range=% RemoveExtraWhitespaces <line1>,<line2>s/\s\+$//

" }}}

" {{{ Tabularize block
com -nargs=1 -range Tabularize <line1>,<line2>!column -t -s<args> -o<args>

" }}}


" {{{ Miscellaneous
set modeline      " Set vim settings from file comments (modeline)
set ignorecase    " Required for smartcase below
set smartcase     " Case insensitive search if lowercase only
set incsearch     " Live search while typing
set showcmd       " Show current normal sequence
set number        " Show line numbers
set winwidth=85   " 80 + 4 (line numbers) + 1 (signs)
set winheight=10  " Sounds good

" Save as root
cnoremap w!! w !sudo tee > /dev/null %

" Disable moves in insert mode
inoremap <UP> <nop>
inoremap <DOWN> <nop>
inoremap <LEFT> <nop>
inoremap <RIGHT> <nop>
inoremap <HOME> <nop>
inoremap <END> <nop>

" Pathogen
exe pathogen#infect()

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" }}}
"


" {{{ Load local settings if any

" Local
if filereadable($HOME . "/.config/nvim/local.vim")
  source $HOME/.config/nvim/local.vim
endif

" Vim projects
if filereadable(".project.vim")
  source .project.vim
endif

" }}}
