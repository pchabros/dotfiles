return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      rust_analyzer = {},
      r_language_server = {},
      dockerls = {},
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "sass",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "r",
        },
      },
    },
  },
  init = function()
    require("lazyvim.util").on_attach(function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end)
    local lsp = require("lspconfig")
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- add a keymap
    keys[#keys + 1] = { "H", vim.lsp.buf.hover, desc = "Hover" }

    lsp.pylsp.setup({
      settings = {
        pylsp = {
          plugins = {
            flake8 = {
              enabled = true,
            },
            pycodestyle = {
              enabled = false,
            },
          },
        },
      },
    })
    lsp.tailwindcss.setup({
      settings = {
        tailwindCSS = {
          hovers = true,
          suggestions = true,
          codeActions = true,
        },
      },
    })
    lsp.eslint.setup({
      root_dir = lsp.util.root_pattern(
        "angular.json",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json"
      ),
    })
  end,
}
