-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local del = vim.keymap.del
local set = vim.keymap.set
local input = vim.fn.input

-- delete some mappings
del("n", "<leader>qq")
del("n", "<leader>|")
del("n", "<leader>-")

-- split
map("n", "<leader>v", ":vsplit<cr>")
map("n", "<leader>h", ":split<cr>")

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
map("v", "K", "10j")
map("v", "L", "10k")

-- move outside bracket/quote in normal mode
map("i", ";;", "<Esc>la")
map("i", "jj", "<Esc>i")

-- don't jump to the next after pressing *
map("n", "*", ":keepjumps normal! mi*`i<cr>")

-- remove highlight with one key
map("n", "h", ":noh<cr>")

-- rest
set({ "n", "x", "o" }, "<leader>rr", "<Plug>RestNvim")
set({ "n", "x", "o" }, "<leader>rp", "<Plug>RestNvimPreview")
set({ "n", "x", "o" }, "<leader>rl", "<Plug>RestNvimLast")

-- diffview
set({ "n" }, "<leader>gd", function()
  local branch = input("Branch:")
  vim.cmd("DiffviewOpen " .. branch)
end, { desc = "diff" })
set({ "n" }, "<leader>gq", ":DiffviewClose<cr>", { desc = "close" })

-- telescope
set({ "n" }, "<leader>gb", require("telescope.builtin").git_branches, { desc = "branch" })

-- git-conflict
set({ "n" }, "<leader>co", ":GitConflictChooseOurs <cr>", { desc = " Ours" })
set({ "n" }, "<leader>ct", ":GitConflictChooseTheirs <cr>", { desc = " Theirs" })
set({ "n" }, "<leader>cb", ":GitConflictChooseBoth <cr>", { desc = " Both" })
set({ "n" }, "<leader>cn", ":GitConflictChooseNone <cr>", { desc = " None" })
set({ "n" }, "<leader>cc", ":GitConflictListQf <cr>", { desc = " List" })
set({ "n" }, "]x", ":GitConflictNextConflict <cr>", { desc = " Next" })
set({ "n" }, "[x", ":GitConflictPrevConflict <cr>", { desc = " Prev" })

-- tmux-navigator
if os.getenv("TMUX") then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end
