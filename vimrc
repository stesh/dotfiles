set nocompatible "Don't care about vi
scriptencoding utf8
filetype plugin on

if has('unix') 
    let shell='zsh'
endif

if has('gui_running')
    set mousehide
    set guifont="Inconsolata 14pt"
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
set ttyfast
set number 
set ruler
set incsearch
set mouse=a
set ignorecase
set smartcase
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4 shiftround
set dictionary=/usr/share/dict/words
set complete+=k
set wildmenu
set magic
set noerrorbells
set novisualbell
set wrap
set t_vb=
set tm=500
set cm=blowfish

" set omnifunc

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
set foldlevel=12
set foldcolumn=12
set foldtext=KandRFolding()

filetype indent on

set ofu=syntaxcomplete#Complete

au FileType python syn keyword pythonDecorator True None False self

au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2 shiftround

au FileType java let b:jcommenter_class_author='Stephen Shaw <shawsd@tcd.ie>' 
au FileType java let b:jcommenter_file_author='Stephen Shaw <shawsd@tcd.ie>' 
au FileType java source ~/.vim/plugin/jcommenter.vim 
au FileType java map <C-S-c> :call JCommentWriter()<CR> 

set statusline=
set statusline=[%n]\ %F%<\ %m%r%h%w%y[%{&ff}]%=0x%B\ @\ %c%V,\ %l\ /\ %L\ %P
