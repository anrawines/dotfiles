" GENERAL SETTINGS
set nobackup
set number 
set relativenumber 
set cursorline
set mouse=a
set nocompatible
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set termguicolors
set backspace=indent,eol,start
set cmdheight=1
syntax on

" Set the duration of the flash (in milliseconds)
let g:highlightedyank_highlight_duration = 300

" Optional: Change the color of the flash (uses a highlight group)
" 'IncSearch' is the common choice for a bright 'flash'
highlight link HighlightedyankRegion IncSearch
