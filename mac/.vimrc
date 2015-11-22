"general settings
syntax enable

set number
set expandtab
set nocompatible
set autoindent
set autoread
set cursorline

set mouse=a
set tabstop=4
set encoding=utf-8

"vundle settings
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required

"nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


"keymap settings
map <C-n> :NERDTreeToggle<CR>