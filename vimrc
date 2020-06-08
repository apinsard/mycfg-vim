let mapleader = ","

function! PreserveView(cmd)
  let l:winview = winsaveview()
  exe a:cmd
  call winrestview(l:winview)
endfunction

" {{{ Look and feel
set nohls

set list
set listchars=tab:▶-,eol:↵,nbsp:▒,trail:.
" highlight NonText ctermfg=0
" highlight SpecialKey ctermfg=0


let g:color_schemes = ['ubaryd', 'alduin', 'default']

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


" {{{ Make tree to the current file if not exists
com MkTree silent !(a="%"; mkdir -p ${a\%/*})
com WTree execute ':MkTree' | write

" }}}


" {{{ File skeletons
au BufNewFile *.py 0r ~/.config/nvim/skel/skel.py

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

" Make star-search always case sensitive
nnoremap * /\C\<<C-R><C-W>\><CR>

" Save as root
cnoremap w!! w !sudo tee > /dev/null %

" Disable moves in insert mode
inoremap <UP> <Esc><RIGHT><UP>
inoremap <DOWN> <Esc><RIGHT><DOWN>
inoremap <LEFT> <Esc>
inoremap <RIGHT> <Esc>2<RIGHT>
inoremap <HOME> <Esc>^
inoremap <END> <Esc>$
" inoremap <BACKSPACE> <C-O>:echoerr "Don't even think about it"<CR>
" inoremap <DEL> <C-O>:echoerr "Don't even think about it"<CR>

" Tags
command! MakeTags !ctags -R --exclude=@.ctagsignore .

" Fuzzy file search
set path+=**
set wildignore+=**/__pycache__/**,*.mo

" Isort
command! Isort call PreserveView('%!isort -y -')

" Pathogen
exe pathogen#infect()

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" vim-syntastic
let g:syntastic_always_populate_loc_list = 1

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
