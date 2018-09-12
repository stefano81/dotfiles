set nocompatible  " be iMproved, required
filetype off      " required

set clipboard=unnamed

"set term=builtin_ansi
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " required
" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" original repos on github
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'vim-syntastic/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
" python
" Plugin 'python-mode/python-mode'
"Plugin 'jmcantrell/vim-virtualenv'
" javascript
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'isRuslan/vim-es6'
" Plugin 'Raimondi/delimitMate'
Plugin 'lervag/vimtex'
Plugin 'elzr/vim-json'

" go
Plugin 'fatih/vim-go'

Plugin 'lilydjwg/colorizer'

"
Plugin 'othree/html5.vim'
" vim-scripts repos
" non github repos
call vundle#end()             " required
filetype plugin indent on     " required

if has('gui_running')
  set background=dark
else
  let g:solarized_termcolors=256
  set background=dark
endif

set modelines=0
syntax enable
set number
set ruler
set autochdir
set virtualedit=block

colorscheme solarized

" add $ at the end of a changed region
set cpoptions+=$

" autocmd
if has("autocmd")
  " Enable filetype detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indentig.
  filetype plugin indent on
endif

" Command T settings
let g:CommandTInputDebounce = 200
let g:CommandTFileScanner = "watchman"
let g:CommandTWildIgnore = &wildignore . ",**/bower_components/*" . ",**/node_modules/*" . ",**/vendor/*"
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles = 500000

" CtrlP settings
"
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']  " Windows

" YCM
" let g:ycm_add_preview_to_completeopt=0
" let g:ycm_confirm_extra_conf=0
" set completeopt-=preview
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_show_diagnotics_ui = 0
let g:ycm_filetype_blacklist = {}

" Syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
" let g:syntastic_python_checkers = ['pyflakes', 'pylink']

"let g:synstatic_check_on_open=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

" LaTeX
let g:polyglot_disabled = ['latex']


" Javascript
autocmd BufWritePost *.js silent !standard --fix %
let g:jsx_ext_required = 0
" let g:jsx_pragma_required = 1

set autoread

"Some tips from http://stevelosh.com/blog/2010/09/coming-home-to-vim/"
set mouse=a

"set tabstop=4
set expandtab
set shiftwidth=2
set softtabstop=2

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest,full
set visualbell
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set number
set cursorline

let mapleader = ","

"Custom settings
set nofoldenable    " disable folding


" markdown
let g:vim_markdown_folding_disabled=1

" search remap
"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" clear search
nnoremap <leader><space> :noh<cr>

" match the next brace
"nnoremap <tab> %
"vnoremap <tab> %
set wrap
set formatoptions=qrn1
set linebreak
" remap movement to move by column layout
"nnoremap j gj
"nnoremap k gk

"User customizations"

" Strips whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Select pasted text
nnoremap <leader>v V`]

" Buffers
"nnoremap <leader>T :enew<cr>
"nnoremap gy :bnext<CR>
"nnoremap gt :bprevious<cr>
"nnoremap gd :bdelete<cr>
"nnoremap <leader>bl :ls<CR>

" Powerline
set guifont=Inconsolata-g\ for\ Powerline:h11
let g:Powerline_symbols = 'fancy'
set t_Co=256
set fillchars+=stl:\ ,stlnc:\

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled =1
let g:airline_theme='molokai'
nnoremap <leader>d :NERDTreeToggle<CR>

augroup file_types
  autocmd!
  autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
  autocmd BufRead,BufNewFile *.md set filetype=markdown setlocal spell spelllang=en_gb
  autocmd BufRead,BufNewFile *.txt set filetype=markdown setlocal spell spelllang=en_gb
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.test set filetype=php
  autocmd BufRead,BufNewFile *.inc set filetype=php
  autocmd BufRead,BufNewFile *.profile set filetype=php
  autocmd BufRead,BufNewFile *.view set filetype=php
  autocmd BufRead,BufNewFile *.less set filetype=less
  autocmd BufRead,BufNewFile *.js set ft=javascript syntax=javascript
  autocmd BufRead,BufNewFile *.ts set ft=typescript syntax=typescript
  autocmd BufRead,BufNewFile *.es6 set ft=javascript syntax=javascript
  autocmd BufRead,BufNewFile *.json set ft=json syntax=javascript
  autocmd BufRead,BufNewFile *.twig set ft=htmldjango
  autocmd BufRead,BufNewFile *.rabl set ft=ruby
  autocmd BufRead,BufNewFile *.jade set ft=jade
  autocmd BufRead,BufNewFile *.tex set filetype=tex syntax=tex setlocal spell spelllang=en_gb
  autocmd BufRead,BufNewFile *.scala set filetype=scala
  autocmd BufRead,BufNewFile *.sbt set filetype=sbt.scala
augroup END

" Whitespace fixes
" highlight ExtraWhitespace ctansiermbg=red guibg=red
" match ExtraWhitespace /\s\+$/

augroup whitespace
    autocmd!
    autocmd BufWinEnter * match BadWhitespace /\s\+$/
    autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match BadWhitespace /\s\+$/
    autocmd BufRead,BufNewFile * match BadWhitespace /^\t\+/
    autocmd BufWinLeave * call clearmatches()
augroup END

set undolevels=20
set title

set noerrorbells
set noswapfile
set nobackup
nnoremap ; :

" Tabular
" nnoremap <leader>a= :Tabularize /=<CR>
" vnoremap <leader>a= :Tabularize /=<CR>
" nnoremap <leader>a: :Tabularize /:\zs<CR>
" vnoremap <leader>a: :Tabularize /:\zs<CR>

" Abbreviations
" iabbrev waht what
" nnoremap H 00
" nnoremap L $
inoremap jk <esc>

set fileformat=unix
set fileformats=unix,dos

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Python, PEP-008
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set textwidth=139
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set autoindent
au         BufNewFile *.py,*.pyw set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'
let g:pymode_link_on_write = 0
let g:pymode_python = 'python3'

" JS, standard
au BufRead,BufNewFile *.js set expandtab
au BufRead,BufNewFile *.js set tabstop=2
au BufRead,BufNewFile *.js set softtabstop=2
au BufRead,BufNewFile *.js set shiftwidth=2
au BufRead,BufNewFile *.js set autoindent
au         BufNewFile *.js set fileformat=unix
au BufRead,BufNewFile *.js let b:comment_leader = '//'

" Abbreviations
augroup abbreviations
  autocmd!
  autocmd FileType html :iabbrev <buffer> --- &mdash;
augroup END
