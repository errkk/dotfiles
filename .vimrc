let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle"
Bundle 'gmarik/vundle'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'

" Syntaxes
Bundle 'leshill/vim-json'
Bundle 'rodjek/vim-puppet'
Bundle 'groenewege/vim-less'

" Python
Bundle 'kevinw/pyflakes-vim'
Bundle 'fs111/pydoc.vim'
Bundle 'atourino/jinja.vim'
Bundle 'vim-scripts/python_match.vim'


" Change leader
let mapleader = ","
let g:mapleader = ","

filetype off
filetype plugin indent on

set nocompatible
set modelines=0
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
