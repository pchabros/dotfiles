" PLUGINS ---------------------------------------------------

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
  Plug 'ap/vim-css-color'
  Plug 'chrisbra/csv.vim'
  Plug 'moll/vim-bbye'
  Plug 'simeji/winresizer'
  Plug 'junegunn/fzf.vim'
  Plug 'simnalamburt/vim-mundo'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'jiangmiao/auto-pairs'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'honza/vim-snippets'
  Plug 'neomake/neomake'
  Plug 'itchyny/lightline.vim'
  Plug 'tmux-plugins/vim-tmux'
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

" Config Nvim-R
function! s:customNvimRMappings()
  nmap <buffer> <Leader>tr <Plug>RStart
  imap <buffer> <Leader>tr <Plug>RStart
  vmap <buffer> <Leader>tr <Plug>RStart
  nmap , <Plug>RDSendLine
  vmap , <Plug>RDSendSelection
endfunction
augroup myNvimR
  au!
  autocmd filetype r call s:customNvimRMappings()
augroup end
let R_assign = 0
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_bracketed_paste = 1
let r_indent_align_args = 0

" Config for coc.vim
let g:coc_global_extensions = [
  \ 'coc-r-lsp',
  \ 'coc-snippets',
  \ 'coc-css', 
  \ 'coc-html',
  \ 'coc-json', 
  \]

let g:python3_host_prog = '/usr/bin/python3'

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Config for neomake
let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
  \   'text': '',
  \   'texthl': 'NeomakeWarningSign',
  \ }
let g:neomake_message_sign = {
  \   'text': '',
  \   'texthl': 'NeomakeWarningSign',
  \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

call neomake#configure#automake('w')

command! -bang -nargs=* -complete=file Make NeomakeProject <args>

let g:neomake_sh_enabled_makers = ['shellcheck']
let g:neomake_vim_enabled_makers = ['vint']

" Config lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ }

" MAPPINGS --------------------------------------------------

" escape
imap jk <Esc>
imap kj <Esc>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

nnoremap <space> <nop>
let mapleader = " "

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

