set nocompatible "Don't care about vi
scriptencoding utf8
filetype plugin on

if has('unix') 
    let shell='zsh'
endif

if has('gui_running')
    set mousehide
    set guifont=Menlo
    colors evening
    set guioptions-=T
else
    colors default
endif

syntax on
set backspace=2
set mouse=a
set ttyfast
set ff=unix ffs=unix,dos
set autoindent smartindent
set formatoptions+=r
set textwidth=80
set showmatch
set vb t_vb=
set ttyfast
set number 
set ruler
set incsearch
set mouse=a
set ignorecase
set smartcase
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set shiftround
set dictionary=/usr/share/dict/words
set complete+=k

"""
" Folding
"
function! KandRFolding()
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|{\d\=', '', 'g')
    return v:folddashes . sub
endfunction

set foldmethod=indent
set foldnestmax=10
set foldlevel=0
set foldcolumn=12
set foldtext=KandRFolding()

filetype indent on
