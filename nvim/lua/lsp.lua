-- languageserver R
require("lspconfig").r_language_server.setup({
  settings = {
    filetypes = { "r", "rmd", "rpr" },
    r = {
      lsp = {
        debug = true,
        path = "/usr/local/bin/R"
      },
      rpath = {
        mac = "/usr/local/bin/R"
      }
    }
  },
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

-- Tree-sitter
local ts = require("nvim-treesitter.configs")
ts.setup({ ensure_installed = "maintained", highlight = { enable = true } })

-- completion related settings
local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "cmp_tabnine" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" })
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( "confirm_done", cmp_autopairs.on_confirm_done({
  map_cr = true,
  map_complete = true,
  auto_select = true,
  insert = false,
  map_char = {
    all = "(",
    tex = "{"
  }
}))

cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- solidity
require("lspconfig").solidity_ls.setup({})
require("lspconfig").solang.setup({})

-- web
require("lspconfig").html.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup({
  capabilities = capabilities,
})
require("lspconfig").tsserver.setup({})
require("lspconfig").vuels.setup({})
require("lspconfig").eslint.setup({})
vim.api.nvim_exec([[autocmd BufWritePre <buffer> EslintFixAll]], true)

-- popups (lspsaga)
local saga = require("lspsaga")
saga.init_lsp_saga({
  border_style = "round",
  rename_action_keys = {
    quit = "<Esc>"
  }
})

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.completion.spell,
  },
  -- root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git", ".eslintrc.js"),
})
