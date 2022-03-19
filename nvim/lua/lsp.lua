local lspconfig = require("lspconfig")
vim.opt_global.completeopt = { "menu", "noinsert", "noselect" }
vim.opt_global.shortmess:remove("F"):append("c")
-- languageserver R
lspconfig.r_language_server.setup({
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
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
      require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      with_text = false,
      maxwidth = 90,
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local luasnip = require("luasnip")
luasnip.snippets = {
  html = {}
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require("luasnip/loaders/from_vscode").load({include = { "html" }})
require("luasnip/loaders/from_vscode").lazy_load()

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
lspconfig.solidity_ls.setup({})
-- lspconfig.solang.setup({})
-- lspconfig.solc.setup({})

-- web
lspconfig.html.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup({
  capabilities = capabilities,
})
lspconfig.vuels.setup({})
lspconfig.eslint.setup({})
-- vim.api.nvim_exec([[autocmd FileType vue BufWritePre <buffer> EslintFixAll]], true)

-- typescript
lspconfig.tsserver.setup({})

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
