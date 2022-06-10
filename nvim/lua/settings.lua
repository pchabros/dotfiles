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
opt.spelllang = "ru"
g.timeoutlen = 10
g.ttimeoutlen = 10
g.r_indent_align_args = 0
o.termguicolors = true
cmd("set clipboard^=unnamedplus")

cmd("colorscheme nord")
cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")

local tabline = require("tabline")
tabline.setup({
  enable = false,
  options = {
    show_filename_only = true
  }
})
require("lualine").setup({
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { tabline.tabline_buffers },
    lualine_x = { tabline.tabline_tabs },
    lualine_y = {},
    lualine_z = {},
  },
})

-- telescope
local actions = require("telescope.actions")
local telescope = require("telescope")
telescope.setup({
  defaults = {
    -- file_ignore_patterns = { "node_modules" },
    mappings = {
      n = {
        ["k"] = actions.move_selection_next,
        ["l"] = actions.move_selection_previous,
      }
    }
  }
})

telescope.load_extension("fzf")
telescope.load_extension("neoclip")

-- hop
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
vim.cmd("hi HopNextKey guifg=#a3be8c")
vim.cmd("hi HopNextKey1 guifg=#88c0d0")
vim.cmd("hi HopNextKey2 guifg=#b48ead")

-- trouble
require("trouble").setup({
  action_keys = {
    hover = "H",
    preview = "p",
    previous = "l",
    next = "k"
  },
})

-- cutlass
require("cutlass").setup({
  cut_key = "z"
})

-- neoclip
require("neoclip").setup({})

--terminal
require("terminal").setup({})

--dap
local dap = require('dap')
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })

-- shade
require 'shade'.setup({
  overlay_opacity = 80
})

-- gitgutter
g.gitgutter_sign_modified = ''
g.gitgutter_sign_removed = '-'
g.gitgutter_sign_removed_first_line = ''
g.gitgutter_sign_removed_above_and_below = ''
g.gitgutter_sign_modified_removed = ''

--rest
require("rest-nvim").setup({
  -- result_split_horizontal = true,
  jump_to_request = true,
  show_url = false,
  show_http_info = false,
  show_headers = false,
})

-- dressing
-- require('dressing').setup({
  -- prompt_align = 'center',
-- })

-- require('range-highlight').setup {}

require('cinnamon').setup({
  extra_keymaps = true,
})

-- slime
g.slime_target = 'tmux'
g.slime_default_config = {
  socket_name = "default", target_pane = "{last}"
}
g.slime_dont_ask_default = 1

-- indent blankline
vim.opt.list = true
-- vim.opt.listchars:append("space:∙")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  show_end_of_line = true,
  -- space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}
