set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle help
" " """""""""""
" " :PluginList          - list configured bundles
" " :PluginInstall(!)    - install(update) bundles
" " :PluginSearch(!) foo - search(or refresh cache first) for foo
" " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles

" let Vundle manage Vundle
Plugin 'gmarik/Vundle'

" VCS
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" System
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'corntrace/bufexplorer'
Plugin 'goldfeld/vim-seek'

" Syntaxes
Plugin 'leshill/vim-json'
Plugin 'skammer/vim-css-color'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'saltstack/salt-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'Shougo/neomru.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'burnettk/vim-angular'
Plugin 'sophacles/vim-processing'

" Neo Complete
Plugin 'Shougo/neocomplete.vim'

" Python bundles
Plugin 'fs111/pydoc.vim'
Plugin 'nvie/vim-flake8'
Plugin 'atourino/jinja.vim'
Plugin 'vim-scripts/python_match.vim'
Plugin 'scrooloose/syntastic'

" Ruby specific
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'

" Fun, but not useful
Plugin 'chriskempson/base16-vim'
Plugin 'mgutz/vim-colors'
Plugin 'bling/vim-airline'
Plugin 'Gundo'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:cssColorVimDoNotMessMyUpdatetime = 0

" Neo Complete settings
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
"
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 4
set completeopt+=longest

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplcache_disable_auto_complete=0

let g:airline_powerline_fonts = 1

" Use ag command for ack.vim
if executable('ag')
      let g:ackprg = 'ag --vimgrep'
  endif
endif

" Configurations
""""""""""""""""
set background=dark

" Wildmenu completion
"""""""""""""""""""""
set wildmenu
set wildmode=list:longest,full
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
"let base16colorspace=256
colorscheme base16-default
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
command Q q

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
autocmd BufWritePre *.scss :%s/\s\+$//e

" Custom mappings
""""""""""""""""""
" General
:nmap <C-n> :bnext<CR>
:nmap ; :CtrlPBuffer<CR>

" Change leader
let mapleader = ","
let g:mapleader = ","

" Vim Seek Keys
let g:SeekKey = '<Space>'
let g:SeekBackKey = '<S-Space>'

" Disable S for substitue
let g:seek_subst_disable = 1

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" Plugin configurations
"""""""""""""""""""""""
let g:pep8_map= '+'

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
nmap <silent> <leader>ev :e $MYVIMRC
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

" NERDTree
nnoremap <Leader>g :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" NerdTree Auto Open
autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
