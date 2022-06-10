local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- movement changed to jkl;
map("v", ";", "l")
map("v", "l", "k")
map("v", "k", "j")
map("v", "j", "h")
map("n", ";", "l")
map("n", "l", "k")
map("n", "k", "j")
map("n", "j", "h")

-- move faster vertically
map("n", "K", "<Cmd>lua Scroll('10j', 1)<cr>")
map("n", "L", "<Cmd>lua Scroll('10k', 1)<cr>")

-- normal mode with jk or kj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- select all
map("n", "<leader>,", ":norm ggVG<cr>")

-- manage buffers
map("n", "<leader>b;", ":bn<cr>")
map("n", "<leader>bj", ":bp<cr>")
map("n", "<leader>qq", ":Bdelete<cr>")
map("n", "<leader>qa", ":bufdo :Bdelete<cr>")
map("n", "<leader>sh", ":split<cr>")
map("n", "<leader>sv", ":vsplit<cr>")

-- move outside bracket/quote in normal mode
map("i", ";;", "<Esc>la")
map("i", "jj", "<Esc>i")

-- don't jump to the next after pressing *
map("n", "*", ":keepjumps normal! mi*`i<cr>")

-- next/previous after jumping with f or t
map("n", "'", ";")
map("n", "m", ",")

-- remove highlight with one key
map("n", "h", ":noh<cr>")

-- lsp
map("n", "<leader>ld", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
map("n", "H", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
map("n", "<C-K>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
map("n", "<C-L>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
map("n", "<leader>lr", "<cmd>lua require('lspsaga.rename').rename()<CR>")
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>la", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>") -- buffer diagnostics only
map("n", "d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>fS", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")

-- git
map("n", "<leader>gg", ":Git<cr>")
map("n", "<leader>gc", ":Git commit<cr>")
map("n", "<leader>gp", ":Git push<cr>")
map("n", "<leader>gd", ":Git pull<cr>")
map("n", "<leader>gv", ":Gvdiffsplit")
map("n", "<leader>gu", ":git push --set-upstream origin $(git branch --show-current)<cr>")
map("n", "<leader>gC", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>gB", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>")
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_stash()<cr>")
map("n", "<leader>mm", ":MerginalToggle<cr>")

-- dap
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
map("n", "<leader>dk", "<cmd>lua require'dap'.step_over()<cr>")
map("n", "<leader>d;", "<cmd>lua require'dap'.step_into()<cr>")
map("n", "<leader>dj", "<cmd>lua require'dap'.step_out()<cr>")
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>")
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")

-- trouble
map("n", "<leader>tt", "<cmd>TroubleToggle<CR>")

-- hop
map("n", "<leader>m", "<cmd>:HopChar1<cr>")
map("v", "<leader>m", "<cmd>:HopChar1<cr>")

-- rest
map("n", "<leader>rr", "<Plug>RestNvim")
map("n", "<leader>rp", "<Plug>RestNvimPreview")
map("n", "<leader>rl", "<Plug>RestNvimLast")

-- vim-slime
map("v", ",", ":SlimeSend<cr>")
map("n", ",", ":SlimeSendCurrentLine<cr>")
