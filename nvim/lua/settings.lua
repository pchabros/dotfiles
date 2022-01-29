local cmd = vim.cmd
local opt = vim.opt
local o = vim.o
local g = vim.g

opt.hidden = true
opt.autoread = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.undoreload = 10000
opt.relativenumber = true
opt.number = true
opt.incsearch = true
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.indentexpr = "cindent"
opt.inccommand = "nosplit"
opt.scrolloff = 10
opt.wrap = false
opt.clipboard = "unnamedplus"
opt.spelllang = "ru"
g.timeoutlen = 100
g.r_indent_align_args = 0
o.termguicolors = true

cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")
cmd("colorscheme nord")
cmd("let g:airline#extensions#tabline#enabled = 1")
cmd("let g:airline_powerline_fonts = 1")

-- telescope
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules" },
  },
})

-- hop
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
vim.cmd("hi HopNextKey guifg=#a3be8c")
vim.cmd("hi HopNextKey1 guifg=#88c0d0")
vim.cmd("hi HopNextKey2 guifg=#b48ead")

-- trouble
require("trouble").setup({})
