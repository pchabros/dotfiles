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
map("n", "K", "10j")
map("n", "L", "10k")

-- normal mode with jk or kj
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- manage buffers
map("n", "<leader>b;", ":bn<cr>")
map("n", "<leader>bj", ":bp<cr>")
map("n", "<leader>bd", ":Bdelete<cr>")
map("n", "<leader>bq", ":bufdo :Bdelete<cr>")
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

-- resize tab to 103 characters
map("n", "<leader>rs", ":vertical resize 103<cr>")

-- lsp
map("n", "<leader>gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
map("n", "H", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
map("n", "<C-K>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
map("n", "<C-L>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
map("n", "<leader>re", "<cmd>lua require('lspsaga.rename').rename()<CR>")
map("n", "<leader>bf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>") -- buffer diagnostics only
map("n", "d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>ds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")

-- git
map("n", "<leader>gg", ":Git<cr>")
map("n", "<leader>gc", ":Git commit<cr>")
map("n", "<leader>gp", ":Git push<cr>")
map("n", "<leader>gu", ":git push --set-upstream origin $(git branch --show-current)<cr>")
map("n", "<leader>glc", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>gf", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>")
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
map("n", "<leader>gt", "<cmd>lua require('telescope.builtin').git_stash()<cr>")
map("n", "<leader>mm", ":MerginalToggle<cr>")

-- trouble
map("n", "<leader>tt", "<cmd>TroubleToggle<CR>")

-- hop
map("n", "<leader>h", "<cmd>:HopChar1<cr>")
map("v", "<leader>h", "<cmd>:HopChar1<cr>")
map("n", "<leader>hl", "<cmd>:HopLine<cr>")
map("v", "<leader>hl", "<cmd>:HopLine<cr>")
