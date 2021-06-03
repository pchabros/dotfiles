" paste from clipboard
set clipboard+=unnamedplus

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" no swap file
set noswapfile

" save undo-trees in files
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000

" set hybrid line number
set number relativenumber

" indent
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
