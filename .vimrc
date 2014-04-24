set encoding=utf-8
set nocompatible               " be iMproved
filetype off
set rtp+=~/.vim/bundle/vundle/
set mouse=a
call vundle#rc()


" Vundle help
" " """""""""""
" " :BundleList          - list configured bundles
" " :BundleInstall(!)    - install(update) bundles
" " :BundleSearch(!) foo - search(or refresh cache first) for foo
" " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" let Vundle manage Vundle
Bundle 'gmarik/vundle'


" VCS
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" System
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'Raimondi/delimitMate'
Bundle 'sophacles/vim-bundle-sparkup'
Bundle 'corntrace/bufexplorer'
Bundle 'goldfeld/vim-seek'

" Syntaxes and such.
Bundle 'leshill/vim-json'
Bundle 'rodjek/vim-puppet'
Bundle 'skammer/vim-css-color'
Bundle 'groenewege/vim-less'
Bundle 'saltstack/salt-vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'sudar/vim-arduino-syntax'
Bundle 'tclem/vim-arduino'

" Python bundles
Bundle 'fs111/pydoc.vim'
Bundle 'nvie/vim-flake8'
Bundle 'atourino/jinja.vim'
Bundle 'vim-scripts/python_match.vim'
Bundle 'scrooloose/syntastic'

" Ruby specific
Bundle "vim-ruby/vim-ruby"
Bundle 'tpope/vim-endwise'

" Fun, but not useful
Bundle 'altercation/vim-colors-solarized'
Bundle 'mgutz/vim-colors'
Bundle 'ehamberg/vim-cute-python'
Bundle 'bling/vim-airline'
Bundle 'Gundo'
Bundle 'tomtom/tlib_vim'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'


filetype plugin indent on
let g:cssColorVimDoNotMessMyUpdatetime = 0

" Neo Complete settings
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_select = 0

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:airline_powerline_fonts = 1


" Configurations
""""""""""""""""
set background=dark

" Wildmenu completion
"""""""""""""""""""""
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=**.class                          " Cursed Java class files

" Save when losing focus
set autowriteall " Auto-save files when switching buffers or leaving vim.
au FocusLost * silent! :wa
au TabLeave * silent! :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

au BufRead,BufNewFile *.html set filetype=html.html

" Colours
colorscheme solarized
" Basic
syntax enable
set number        " always show line numbers
set hidden        " Allow un-saved buffers in background
set clipboard=unnamed " Share system clipboard.
set backspace=indent,eol,start " Make backspace behave normally.
set directory=/tmp// " swap files
set backupskip=/tmp/*,/private/tmp/*
set ffs=unix,dos,mac "Default file types
set nowrap        " don't wrap lines
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "  case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Remove the toolbar if we're running under a GUI (e.g. MacVIM).
if has("gui_running")
  set guioptions=-t
endif

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:→\ ,trail:·

" Tabs & spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set autoindent    " always set autoindenting on
    " copy the previous indentation on autoindenting

" General Code Folding
""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99

" Highlight VCS conflict markers
""""""""""""""""""""""""""""""""
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" :W should save as well
command W w

" Copy visual selection
vmap <C-c> "*y

autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
let g:flake8_ignore="E501,W293"


" General auto-commands
"""""""""""""""""""""""
autocmd FileType * setlocal colorcolumn=0
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Get rid of trailing whitespace highlighting in mutt.
autocmd FileType mail highlight clear ExtraWhitespace
autocmd FileType mail setlocal listchars=

" Crontab auto-commands
"""""""""""""""""""""""
autocmd FileType crontab setlocal backupcopy=yes

" Markdown auto-commands
""""""""""""""""""""""""
autocmd FileType markdown setlocal wrap linebreak nolist

" Ruby Configurations
"""""""""""""""""""""
autocmd filetype ruby set shiftwidth=2 tabstop=2

" PHP Configurations
""""""""""""""""""""
autocmd FileType php setlocal colorcolumn=100

" Python configurations
"""""""""""""""""""""""
au BufNewFile,BufReadPost python setlocal shiftwidth=2 expandtab
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python let g:pep8_map='<F4>'

" Coffeescript configurations
"""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent
au BufNewFile,BufReadPost *.coffee setlocal shiftwidth=2 expandtab

" Javascript configurations
"""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.js setlocal shiftwidth=4 tabstop=4 expandtab

" Get jinja filetype selection working correctly for *.jinja.html files.
au BufNewFile,BufReadPost *.html.jinja setlocal filetype=htmljinja

" Ardiuno filetypes
"""""""""""""""""""""""""""
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Make sure we hilight extra whitespace in the most annoying way possible.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.less :%s/\s\+$//e

" Custom mappings
""""""""""""""""""

" Genral
noremap <silent> <F3> :QFix<CR>
:nmap <C-n> :bnext<CR>
:nmap ; :CtrlPBuffer<CR>

" Change leader
let mapleader = ","
let g:mapleader = ","

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


" Plugin configurations
"""""""""""""""""""""""         "
let g:pep8_map= '+'

" TagBar
nnoremap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autoshowtag = 1

" NERDTree
nnoremap <Leader>g :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Sparkup
let g:sparkupExecuteMapping = '<c-y>'
let g:sparkupNextMapping = '<c-k>'

" Status Line
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0

let &t_Co=256

" Show all open buffers
noremap <leader>b :BufExplorer<return>

" Gundo
nnoremap <leader>u :GundoToggle<CR>
inoremap <leader>u <c-o>:GundoToggle<CR>

" Vimrc stuff
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Git shortcuts
map <leader>gs :Gstatus<CR>
map <leader>gw :Gwrite<CR>
map <leader>gc :Gcommit<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>ge :Gedit<CR>

if has('gui_running')
    let g:Powerline_symbols = 'fancy'
endif
"
" <space>w to jump to any word,
" <space>f to jump to an occurence of a letter
" <space>j to jump to any line
let g:EasyMotion_leader_key = '<Space>'

autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on
