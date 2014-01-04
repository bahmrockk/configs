
let &runtimepath='~/.config/vim,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,'

" Configurations from ~/.config/vim: 

source ~/.config/vim/filetypes.vim
source ~/.config/vim/dim.vim

syntax on 
set background=dark
colorscheme solarized
let g:solarized_termcolors=16
set t_Co=16
call togglebg#map("<F5>")
filetype plugin indent on
set number

"tab circulation
map <F7> :tabp<CR>
map <F8> :tabn<CR>
" Tab specific option
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs
