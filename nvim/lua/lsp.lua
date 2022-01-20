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

local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

cmp.setup({
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
    -- { name = "buffer" },
  },
  sorting = {
    comparators = {
      lspkind_comparator({
        kind_priority = {
          Field = 11,
          Property = 11,
          Constant = 10,
          Keyword = 11,
          Enum = 10,
          EnumMember = 10,
          Event = 10,
          Function = 10,
          Method = 10,
          Operator = 10,
          Reference = 10,
          Struct = 10,
          Variable = 9,
          File = 8,
          Folder = 8,
          Class = 5,
          Color = 5,
          Module = 5,
          Constructor = 1,
          Interface = 1,
          Snippet = 0,
          TypeParameter = 1,
          Unit = 1,
          Value = 1,
          Text = 0,
        },
      }),
      label_comparator,
    },
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
