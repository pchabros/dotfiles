return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources, {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = "#{m} ",
      }),
      null_ls.builtins.code_actions.eslint_d,
    })
  end,
}
