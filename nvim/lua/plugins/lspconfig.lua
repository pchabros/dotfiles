return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      rust_analyzer = {},
      r_language_server = {},
      dockerls = {},
      pylsp = {
        pylsp = {
          plugins = {
            flake8 = {
              enabled = true,
            },
          },
        },
      },
    },
  },
  init = function()
    require("lazyvim.util").on_attach(function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    function diagnostic_goto(next, severity)
      local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
      severity = severity and vim.diagnostic.severity[severity] or nil
      return function()
        go({ severity = severity })
      end
    end
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- add a keymap
    keys[#keys + 1] = { "H", vim.lsp.buf.hover, desc = "Hover" }
  end,
}
