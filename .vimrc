set encoding=utf-8

call plug#begin('~/.vim/plugged')

" VCS
Plug 'airblade/vim-gitgutter'

" System
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'corntrace/bufexplorer'
Plug 'goldfeld/vim-seek'

" Syntaxes
Plug 'leshill/vim-json'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'davidhalter/jedi-vim'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'elixir-lang/vim-elixir'
Plug 'w0rp/ale'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }

" Auto Complete
Plug 'valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'tpope/vim-repeat'

" Python bundles
Plug 'nvie/vim-flake8'
Plug 'atourino/jinja.vim'
Plug 'vim-scripts/python_match.vim'

" Ruby specific
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'

" Colours
Plug 'joshdick/onedark.vim'

" Stuff
Plug 'mgutz/vim-colors'
Plug 'bling/vim-airline'
Plug 'Gundo'
Plug 'editorconfig/editorconfig-vim'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'JamshedVesuna/vim-markdown-preview'

" All of your Plugins must be added before the following line
call plug#end()
"filetype plugin indent on    " required
filetype indent off
syntax off

:command Wq wq
:command W w
:command Q q
:command Qa qa

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript,jsx setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
set completeopt=noselect,menuone
set shortmess+=c

let g:airline_powerline_fonts = 1

if has('gui_running')
  set guioptions=-t
  let g:Powerline_symbols = 'fancy'
  set guifont=Monaco\ for\ Powerline:h12
endif

" Use ag command for ack.vim
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    let g:agprg='ag -S --nocolor --nogroup --column --ignore "*/node_modules/*" --ignore "*/public/*"'
endif

let g:flow#omnifunc = 1
let g:flow#enable = 0
let g:flow#autoclose = 1

""" Auto reformat JS
"format javascript on save with prettier
if executable('prettier')
  "autocmd BufWritePre *.js call PrettierFormat()
  "autocmd BufWritePre *.jsx call PrettierFormat()
  :command FormatJs call PrettierFormat()
endif

"much of the following code is taken/repurposed from fatih/vim-go:
"https://github.com/fatih/vim-go/blob/1425dec/autoload/go/fmt.vim
function! PrettierFormat() abort
  "save cursor position and many other things
  let l:curw = winsaveview()

  "write current unsaved buffer to a temp file
  let l:tmpname = tempname()
  call writefile(getline(1, '$'), l:tmpname)

  "format temp file and replace actual file
  let out = system('prettier --write ' . l:tmpname)
  if v:shell_error == 0
    call PrettierUpdateFile(l:tmpname, expand('%'))
  else
    "we didn't use the temp file, so clean up
    call delete(l:tmpname)
  endif

  "restore our cursor/windows positions
  call winrestview(l:curw)
endfunction

"replaces the target file with the formatted source file
function! PrettierUpdateFile(source, target)
  "remove undo point caused via BufWritePre
  try | silent undojoin | catch | endtry

  let old_fileformat = &fileformat
  if exists('*getfperm')
    "save file permissions
    let original_fperm = getfperm(a:target)
  endif

  call rename(a:source, a:target)

  "restore file permissions
  if exists('*setfperm') && original_fperm != ''
    call setfperm(a:target , original_fperm)
  endif

  "reload buffer to reflect latest changes
  silent! edit!

  let &fileformat = old_fileformat
  let &syntax = &syntax
endfunction

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
syntax enable
let &t_Co=256
set background=dark
colorscheme onedark
let g:airline_theme='onedark'
let g:onedark_termcolors=16

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
set modelines=1
set cursorline
set lazyredraw

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:→\ ,trail:·

" Tabs & spaces
set tabstop=2     " a tab is four spaces
set shiftwidth=2  " number of spaces to use for autoindenting
set softtabstop=2
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
" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

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
au BufNewFile,BufReadPost *.js setlocal shiftwidth=2 tabstop=2 expandtab

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
:nmap ; :Buffers<CR>
:nmap <C-p> :GFiles<CR>

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


" ALE
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_sign_error = '👎'
let g:ale_sign_warning = '😞'

let g:ale_linters = {
\  'scss': [],
\}

" Status Line
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

" Show all open buffers
noremap <leader>b :BufExplorer<return>

" Gundo
nnoremap <leader>u :GundoToggle<CR>
inoremap <leader>u <c-o>:GundoToggle<CR>

" Vimrc stuff
nmap <silent> <leader>ev :e $MYVIMRC
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Allow accidental capital q to quit
noremap Q :quit<CR>

" NERDTree
nnoremap <Leader>g :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" NerdTree Auto Open
"autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

" Jedi-vim override goto command that intergeres with NerdTree
let g:jedi#goto_assignments_command = "<leader>K"

" FZF Options
"""""""""""""

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Markdown Preview
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'

" Manage line joins without messing up comment formatting
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
