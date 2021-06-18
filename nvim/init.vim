" PLUGINS ---------------------------------------------------

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
  Plug 'ap/vim-css-color'
  Plug 'chrisbra/csv.vim'
  Plug 'moll/vim-bbye'
  Plug 'simeji/winresizer'
  Plug 'junegunn/fzf.vim'
  Plug 'simnalamburt/vim-mundo'
  Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" Config for chrisbra/csv.vim
augroup filetype_csv
  autocmd! 
  autocmd BufRead,BufWritePost *.csv :%ArrangeColumn!
  autocmd BufWritePre *.csv :%UnArrangeColumn
augroup END

" Config for fzf.vim
nnoremap <leader>f :Files<cr>
nnoremap <c-w>h <c-w>s

" MAPPINGS --------------------------------------------------

nnoremap <space> <nop>
let mapleader = "\<space>"

" next buffer/tab
nnoremap <leader>bn :bn<cr>
nnoremap <leader>tn gt

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" remap hjkl
noremap ; l
noremap l k
noremap k j
noremap j h

" SETTINGS --------------------------------------------------

" switch buffer without saving
set hidden

" paste from clipboard
set clipboard+=unnamedplus

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

" Show substitution
set inccommand=nosplit

