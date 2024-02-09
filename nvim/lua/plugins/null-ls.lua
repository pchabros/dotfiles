return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local formatting = require("null-ls").builtins.formatting
    local diagnostics = require("null-ls").builtins.diagnostics
    local code_actions = require("null-ls").builtins.code_actions
    local h = require("null-ls.helpers")
    local u = require("null-ls.utils")

    opts.sources = vim.list_extend(opts.sources, {
      formatting.prettier,
      -- formatting.prettierd, # `prettierd` not updated for Angular v17
      formatting.yamlfix,
      formatting.beautysh,
      formatting.black,
      diagnostics.eslint_d,
      -- diagnostics.eslint_d.with({
      --   diagnostics_format = "#{m} ",
      --   cwd = h.cache.by_bufnr(function(params)
      --     return u.root_pattern(
      --       "angular.json",
      --       "eslint.config.js",
      --       ".eslintrc",
      --       ".eslintrc.js",
      --       ".eslintrc.cjs",
      --       ".eslintrc.yaml",
      --       ".eslintrc.yml",
      --       ".eslintrc.json",
      --       "package.json"
      --     )(params.bufname)
      --   end),
      -- }),
      diagnostics.shellcheck,
      diagnostics.yamllint,
      diagnostics.zsh,
      code_actions.shellcheck,
      code_actions.refactoring,
    })
  end,
}
