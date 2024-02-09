-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
function Augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "GitConflictDetected",
  callback = function()
    vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
    vim.keymap.set("n", "cww", function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end,
})

-- local plenary = require("plenary")

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = Augroup("organize_imports"),
--   pattern = { "*.ts" },
--   callback = function()
--     local organize_imports = function()
--       vim.lsp.buf.execute_command({
--         command = "_typescript.organizeImports",
--         arguments = { vim.api.nvim_buf_get_name(0) },
--         title = "",
--       })
--     end
--     local write_buffer = function()
--       vim.cmd("write")
--     end
--     plenary.async.run(organize_imports, write_buffer)
--   end,
-- })
