local opt = vim.opt
vim.cmd("colorscheme nord")
require("lualine").setup({
  options = {
    theme = "nord"
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"filename"},
    lualine_c = {""},
    lualine_x = {"encoding", "fileformat"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {"branch"},
    lualine_b = {"filename"},
    lualine_c = {"filetype"},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
})
vim.g.colorizer_auto_color = 1
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
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.inccommand = "nosplit"
opt.scrolloff = 10
opt.wrap = false
opt.clipboard = "unnamedplus"
