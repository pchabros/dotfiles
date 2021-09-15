" PLUGINS ---------------------------------------------------

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
  Plug 'airblade/vim-gitgutter'
  Plug 'ap/vim-css-color'
  Plug 'arcticicestudio/nord-vim'
  Plug 'chrisbra/csv.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'gennaro-tedesco/nvim-peekup'
  Plug 'honza/vim-snippets'
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'jiangmiao/auto-pairs'
  Plug 'joeytwiddle/sexy_scroller.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'mileszs/ack.vim'
  Plug 'moll/vim-bbye'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neomake/neomake'
  Plug 'phaazon/hop.nvim'
  Plug 'rizzatti/dash.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'simeji/winresizer'
  Plug 'simnalamburt/vim-mundo'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'tmux-plugins/vim-tmux'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'w0rp/ale'
  Plug 'yuezk/vim-js'
call plug#end()

" Config for chrisbra/csv.vim
augroup filetype_csv
  autocmd! 
  autocmd BufRead,BufWritePost *.csv :%ArrangeColumn!
  autocmd BufWritePre *.csv :%UnArrangeColumn
augroup END

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
  \ 'coc-tsserver',
  \ 'coc-r-lsp',
  \ 'coc-snippets',
  \ 'coc-css', 
  \ 'coc-html',
  \ 'coc-json', 
\ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

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

set signcolumn=number

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Config for ALE
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
let g:ale_r_lintr_options = "with_defaults(line_length_linter(100))"
let g:ale_fix_on_save = 1

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

" Config nvim-peekup
let g:peekup_open = "<leader>'"

" Config for gitgutter
set updatetime=100
let g:gitgutter_max_signs = -1
set foldtext=gitgutter#fold#foldtext()
let g:gitgutter_sign_removed = '-'

" Config hop
hi HopNextKey guifg=#b48ead
hi HopNextKey1 guifg=#b48ead
hi HopNextKey2 guifg=#b48ead
hi HopUnmatched guifg=#e5e9f0

map s <cmd>HopChar1<CR>
omap s v<cmd>HopChar1<CR>

lua << EOF
require'hop'.setup()
EOF

" MAPPINGS --------------------------------------------------

" reload init.vim
nnoremap <leader>z :source $DOTFILES/nvim/init.vim<cr>

" jump to end in insert
imap ;; <Esc>;a

" jump down and up
nnoremap K 10j
nnoremap L 10k

" escape
imap jk <Esc>
imap kj <Esc>
tnoremap jk <C-\><C-n>
tnoremap jk <C-\><C-n>

" leader
nnoremap <space> <nop>
let mapleader = " "

" next buffer/tab
nnoremap <leader>b; :bn<cr>
nnoremap <leader>bj :bp<cr>
nnoremap <leader>tn gt
nnoremap <leader>bd :Bdelete<cr>
nnoremap <leader>bq :bufdo :Bdelete<cr>

" new window
nnoremap <leader>sh :split<cr>
nnoremap <leader>sv :vsplit<cr>

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" remap f{search} next/previous
noremap ' ;
noremap m ,

" remap hjkl
noremap ; l
noremap l k
noremap k j
noremap j h

" turn off highlight
nmap h :noh<cr>

" resize
let g:winresizer_keycode_left = 106
let g:winresizer_keycode_down = 107
let g:winresizer_keycode_up = 108
let g:winresizer_keycode_right = 59

" Config for fzf.vim
nnoremap <leader>n :FZF<cr>

" Config for acf.vim
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Config for Dash
nnoremap <leader>d :Dash<cr>

" SETTINGS --------------------------------------------------

" theme
colorscheme nord
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" encoding
set encoding=UTF-8

" vertical line after 100 characters
set colorcolumn=100

" switch buffer without saving
set hidden

" paste from clipboard
set clipboard+=unnamedplus

" auto-reload files
set autoread

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

" Keep cursor centered
set scrolloff=10
