let mapleader = " "
" -- General Mappings ---
" Netrw ( File Explorer )
nnoremap <leader>cd :Ex<CR>
" Fast Sourcing Vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>q :wq<CR>

" Fast escape from insert
inoremap jk <esc>

" Move visual blocks (Visual Mode)
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

" Move single lines (Normal Mode)
nnoremap <Up> :m .-2<CR>==
nnoremap <Down> :m .+1<CR>==

" Clear search highlighting ( No Hightlight )
nnoremap <leader>nh :nohlsearch<CR>

" --- Plugin: OSCYank ---
vnoremap <leader>c :OSCYank<CR>
vnoremap <leader>c :OSCYankVisual<CR>

" --- Plugin: Startify Screen ---
nnoremap <leader>h :Startify<CR>
