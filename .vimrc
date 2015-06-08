"""
" My preferences so far...
"""

set nocompatible " be iMproved, required
filetype off     " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrollloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()	  "required
filetype plugin indent on "required

"set background=dark
colorscheme elflord

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch
set wrapscan		" Search starts at the beginning of the buffer after having reached its end
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

set backspace=indent,eol,start
set history=100
set ruler
set modeline

set clipboard=unnamedplus

" open eclim quickfix window
command PP ProjectPloblems
nnoremap <silent> <Leader>js :JavaSearchContext

let g:EclimCompletionMethod = 'omnifunction'


let g:tex_flavor='latex'
