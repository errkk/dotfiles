set encoding=utf-8

call plug#begin('~/.vim/plugged')

" VCS
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" System
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rbgrouleff/bclose.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'corntrace/bufexplorer'
Plug 'goldfeld/vim-seek'

" Syntaxes
Plug 'w0rp/ale'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'davidhalter/jedi-vim'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chr4/nginx.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'stephenway/postcss.vim'
Plug 'styled-components/vim-styled-components'
Plug 'vim-ruby/vim-ruby'
Plug 'noprompt/vim-yardoc'
Plug 'skwp/vim-rspec'
Plug 'hashivim/vim-terraform'
Plug 'rhysd/conflict-marker.vim'
Plug 'jceb/vim-orgmode'
Plug 'leafgarland/typescript-vim'
Plug 'jparize/vim-graphql'


" Auto Complete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-repeat'
Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python bundles
Plug 'atourino/jinja.vim'
Plug 'vim-scripts/python_match.vim'
Plug 'ambv/black'

" Colours
"Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'

" Stuff
Plug 'mgutz/vim-colors'
Plug 'bling/vim-airline'
"Plug 'Gundo'
Plug 'editorconfig/editorconfig-vim'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-endwise'
Plug 'mhinz/vim-mix-format'

" It's recommended to put this last
Plug 'ryanoasis/vim-devicons'

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

"let g:deoplete#enable_at_startup = 1

"autocmd FileType tsx  let b:deoplete_disable_auto_complete = 1
"autocmd FileType ts  let b:deoplete_disable_auto_complete = 1

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
let g:flow#showquickfix = 0

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

" Mix format Elixir on save
let g:mix_format_on_save = 0
let g:mix_format_silent_errors = 1

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

" Nord configs, before colorscheme
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1

colorscheme nord
"let g:airline_theme='onedark'
"let g:onedark_termcolors=16

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
let g:conflict_marker_highlight_group = 'Error'

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin ctermbg=DarkGreen ctermfg=white cterm=bold
highlight ConflictMarkerOurs ctermbg=LightGreen ctermfg=black
highlight ConflictMarkerTheirs ctermbg=LightRed ctermfg=black
highlight ConflictMarkerEnd ctermbg=DarkRed ctermfg=white cterm=bold

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v
" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Dont replace register with thing thats being pasted over
xnoremap P pgvy

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
autocmd FileType ruby compiler ruby

" PHP Configurations
""""""""""""""""""""
autocmd FileType php setlocal colorcolumn=100

" Python configurations
"""""""""""""""""""""""
au BufNewFile,BufReadPost python setlocal shiftwidth=2 expandtab
autocmd FileType python setlocal colorcolumn=88
autocmd FileType python let g:pep8_map='<F4>'
let g:python3_host_prog = '/usr/local/bin/python3'

" Javascript configurations
"""""""""""""""""""""""""""
autocmd BufNewFile,BufReadPost *.js setlocal shiftwidth=2 tabstop=2 expandtab
autocmd BufNewFile,BufReadPost *.tf setlocal shiftwidth=2 tabstop=2 expandtab

" Get jinja filetype selection working correctly for *.jinja.html files.
autocmd BufNewFile,BufReadPost *.html.jinja setlocal filetype=htmljinja

" Ardiuno filetypes
"""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.pde set filetype=arduino
autocmd BufRead,BufNewFile *.ino set filetype=arduino

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
:nmap ; :Buffers<CR>
:nmap <C-p> :GFiles<CR>

" Change leader
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

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
\  'javascript': ['flow', 'eslint'],
\  'python': ['flake8', 'pylint', 'mypy']
\}

let g:ale_fixers = {
\  'ruby': ['rufo']
\}

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

" Status Line
"set laststatus=2
"set statusline+=%#warningmsg#
"set statusline+=%{LinterStatus()}
"set statusline+=%*

let g:airline#extensions#ale#enabled=1

nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

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

" Display in a window, instead of at the bottom
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


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

" Markdown Preview
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'

" Manage line joins without messing up comment formatting
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

let g:vim_json_syntax_conceal=0

:set number relativenumber

:augroup numbertoggle
:  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
