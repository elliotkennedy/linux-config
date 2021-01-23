filetype plugin indent on

set swapfile
set dir=~/.vimswp//
set backupdir=~/.vimbackup//
set undodir=~/.vimundo//

set tabstop=4 " show existing tab with 4 spaces width
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set invnumber " line numbers
set mouse=a " mouse support with copy paste
set clipboard=unnamedplus " use system keyboard
" set cursorline " highlight current line

" Install NERDTree
" git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
" vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

" Quit vim if NERDTree is only remaining when closing a window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" remap ctrl+n to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" remap alt+arrow to navigate vim windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" run NERDTree when vim starts and switch back to file window, focus on
" NERDTree if no file
autocmd vimenter * if argc() == 1 | NERDTree | wincmd p | else | NERDTree | endif

" overwrite file when I forget to sudo
cnoremap w!! w !sudo tee > /dev/null %

