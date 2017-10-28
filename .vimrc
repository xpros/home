" set the color theme for vim
color delek
" show the filename in the window titlebar
set title
" set syntax highlighting
syntax on
filetype on
" enhance command-line completion
" set line numbers
set number
" make vim work more vim-like
set nocompatible
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
"set backupdir=~/.vim/backups
"set directory=~/.vim/swaps
"if exists("&undodir")
"    set undodir=~/.vim/undo
"endif
" does good stuff with buffers
set hidden
" bump up command history
set history=1000
" enable search highlighting
set hlsearch
" ignore case of searches
set ignorecase
" highlight dynamically as pattern is typed
set incsearch
" always show status
set laststatus=2
" set column width reminder
set colorcolumn=80
" disable error bells
set noerrorbells
" show the cursor position
set ruler
" do not show intro message when starting vim
set shortmess=atI
" show current mode
set showmode
" start scrolling three lines before the horizontal window border
set scrolloff=3
" set tabs
"set autoindent
"set smartindent
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
"set expandtab
"set smarttab
"set cindent
"set showmatch
"set matchtime=1
