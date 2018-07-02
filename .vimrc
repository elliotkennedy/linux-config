filetype plugin indent on

set tabstop=4 " show existing tab with 4 spaces width
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set invnumber " line numbers
" set cursorline " highlight current line

cnoremap w!! w !sudo tee > /dev/null %

