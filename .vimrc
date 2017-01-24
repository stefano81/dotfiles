set nocompatible
filetype off

"set term=builtin_ansi
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'jreybert/vimagit'
Plugin 'scrooloose/NERDTree'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'sheerun/vim-polyglot'
Plugin 'lervag/vimtex'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'othree/html5.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
" vim-scripts repos
" non github repos
call vundle#end()            " required
filetype plugin indent on     " required!

"set guifont       = "Menlo:12"
"let g:colors_name = "badwolf"
set background    = "light"

set modelines=0
syntax enable
set nu
set ruler
set autochdir

set background=dark

"colorscheme solarized

" remap arrow keys
"noremap <Down> gj
"noremap <Up> gk
"nnoremap <Left> h
"nnoremap <Right> l
"nnoremap <Up> k
"nnoremap <Down> j
"inoremap <up> k
"inoremap <down> j
"inoremap <left> h
"inoremap <right> l

" copy
"vnoremap <C-c> "*y


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
let g:ctrlp_map = '<leader>t'
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

" Syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:synstatic_check_on_open=1

" Javascript
autocmd bufwritepost *.js silent !standard --fix %
set autoread

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
" set relativenumber
set cursorline


" Python, PEP-008
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set textwidth=139
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set autoindent
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
au         BufNewFile *.py,*.pyw set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'


" JS, standard
au BufRead,BufNewFile *.js set expandtab
au BufRead,BufNewFile *.js set tabstop=2
au BufRead,BufNewFile *.js set softtabstop=2
au BufRead,BufNewFile *.js set shiftwidth=2
au BufRead,BufNewFile *.js set autoindent
au BufRead,BufNewFile *.js match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.js match BadWhitespace /\s\+$/
au         BufNewFile *.js set fileformat=unix
au BufRead,BufNewFile *.js let b:comment_leader = '//'


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
nnoremap j gj
nnoremap k gk

"User customizations"

" Strips whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Select pasted text
nnoremap <leader>v V`]

"Window splitting remap"
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>q <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

" Buffers
nnoremap <leader>T :enew<cr>
nnoremap gy :bnext<CR>
nnoremap gt :bprevious<cr>
nnoremap gd :bdelete<cr>
nnoremap <leader>bl :ls<CR>

" Theme stuff
nnoremap <leader>1 :colorscheme obsidian<cr>
nnoremap <leader>2 :colorscheme tomorrow-night-bright<cr>
nnoremap <leader>3 :colorscheme molokai<cr>
nnoremap <leader>4 :colorscheme badwolf<cr>

" badwolf settings
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
let g:badwolf_css_props_highlight = 1
let g:badwolf_html_link_underline = 1

" Powerline
set guifont=Inconsolata-g\ for\ Powerline:h11
let g:Powerline_symbols = 'fancy'
set t_Co=256
set fillchars+=stl:\ ,stlnc:\

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled =1
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

augroup file_types
    autocmd!
    autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.txt set filetype=markdown
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
augroup END

" Whitespace fixes
"highlight ExtraWhitespace ctansiermbg=red guibg=red
"match ExtraWhitespace /\s\+$/

"augroup whitespace
"    autocmd!
"    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"    autocmd BufWinLeave * call clearmatches()
"augroup END

set undolevels=20
set title

set noerrorbells
set noswapfile
set nobackup
nnoremap ; :

" Tabular
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= :Tabularize /=<CR>
nnoremap <leader>a: :Tabularize /:\zs<CR>
vnoremap <leader>a: :Tabularize /:\zs<CR>

" Custom maps
set pastetoggle=<leader>p
nnoremap <leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

nnoremap <leader>vi :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
nnoremap <leader>re gg=G

" Save
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Abbreviations
iabbrev adn and
iabbrev waht what
nnoremap H 00
nnoremap L $
inoremap jk <esc>

" Arrow keys
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"
"inoremap <left> <nop>
"inoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>

set fileformat=unix
set fileformats=unix,dos

" Abbreviations
"augroup abbreviations
    "autocmd!
    "autocmd FileType html :iabbrev <buffer> --- &mdash;
    "autocmd FileType javascript :iabbrev <buffer> ret return
"augroup END
