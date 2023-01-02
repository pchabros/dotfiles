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
-- lualine
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

--nvim-navic
local navic = require("nvim-navic")
vim.o.winbar = "  %{%v:lua.require'nvim-navic'.get_location()%}"
navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  }
}

-- telescope
local actions = require("telescope.actions")
local previewers = require('telescope.previewers')
local previewers_utils = require('telescope.previewers.utils')

local max_size = 10000
local truncate_large_files = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > max_size then
      local comand = {"head", "-c", max_size, filepath}
      previewers_utils.job_maker(comand, bufnr, opts)
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local telescope = require("telescope")
telescope.setup({
  defaults = {
    -- file_ignore_patterns = { "node_modules" },
    buffer_previewer_maker = truncate_large_files,
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

--[[ require("indent_blankline").setup {
  show_end_of_line = true,
  -- space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
} ]]

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', 'h]', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', 'h[', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
