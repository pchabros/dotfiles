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
opt.inccommand = "nosplit"
opt.scrolloff = 10
opt.wrap = false
opt.clipboard = "unnamedplus"
g.timeoutlen = 100
g.r_indent_align_args = 0

g.material_style = "oceanic"
vim.cmd("colorscheme material")
require('lualine').setup {
  options = {
    theme = 'material-nvim'
  }
}
