local opt = vim.opt
local g = vim.g
vim.cmd("colorscheme nord")
local custom_nord = require("lualine.themes.nord")
custom_nord.normal.a.bg = "#ffffff"
custom_nord.normal.a.fg = "#2a89ab"
custom_nord.visual.a.bg = "#2a89ab"
custom_nord.visual.a.fg = "#ffffff"
-- custom_nord.normal.a.gui = null
custom_nord.normal.b.bg = "#2a89ab"
custom_nord.normal.c.bg = "#000000"
custom_nord.inactive.c.bg = "#000000"
require("lualine").setup({
  options = {
    theme = custom_nord
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
require("lspconfig").html.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").tsserver.setup({})
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
