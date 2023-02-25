local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local lspconfig = require("lspconfig")
vim.opt_global.completeopt = { "menu", "noinsert", "noselect" }
-- vim.opt_global.shortmess:remove("F"):append("c")

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
ts.setup({
  ensure_installed = "all",
  highlight = { enable = true },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
})

-- lua
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      hover = {
        enable = false,
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- solidity
lspconfig.solidity_ls.setup({})
vim.cmd('autocmd BufRead *.sol setlocal shiftwidth=4')

-- typescript
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  buf_map(bufnr, "n", "<leader>gd", ":LspDef<CR>")
  buf_map(bufnr, "n", "<leader>re", ":LspRename<CR>")
  buf_map(bufnr, "n", "<leader>td", ":LspTypeDef<CR>")
  buf_map(bufnr, "n", "H", ":LspHover<CR>")
  buf_map(bufnr, "n", "d[", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "d]", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "<leader>ca", ":LspCodeAction<CR>")
  buf_map(bufnr, "n", "<Leader>dl", ":LspDiagLine<CR>")
  buf_map(bufnr, "i", "<leader>sh", "<cmd> LspSignatureHelp<CR>")
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)
    buf_map(bufnr, "n", "<leader>is", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>")
    on_attach(client, bufnr)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
  cmd = { 'html-languageserver', '--stdio' },
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
  capabilities = capabilities,
})
lspconfig.cssls.setup({
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "tsconfig.json"),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    format = {
      enable = true,
    },
  },
  handlers = {
    ["window/showMessageRequest"] = function(_, result)
      if result.message:find("ENOENT") then
        return vim.NIL
      end
      return vim.lsp.handlers["window/showMessageRequest"](nil, result)
    end,
  },
})

local null_ls = require("null-ls")
local prettier = require("prettier")

null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier
  },
  on_attach = on_attach
})

prettier.setup({
  bin = 'prettier', -- or `prettierd`
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  -- prettier format options (you can use config files too. ex: `.prettierrc`)
  arrow_parens = "always",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  end_of_line = "lf",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 80,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = true,
  single_quote = false,
  tab_width = 2,
  trailing_comma = "es5",
  use_tabs = false,
  vue_indent_script_and_style = false,
})

-- completion related settings
local cmp = require("cmp")
local lspkind = require("lspkind")
local from_vscode = require("luasnip.loaders.from_vscode")

cmp.setup({
  snippet = {
    expand = function(args)
      local luasnip = require('luasnip')
      luasnip.lsp_expand(args.body)
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      with_text = false,
      maxwidth = 90,
      before = function(entry, vim_item)
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
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
  map_cr = true,
  map_complete = true,
  auto_select = true,
  insert = false,
  map_char = {
    all = "(",
    tex = "{"
  }
}))

-- cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

-- popups (lspsaga)
local saga = require("lspsaga")
saga.init_lsp_saga({
  border_style = "round",
  rename_action_keys = {
    quit = "<Esc>"
  }
})

-- luasnip
local luasnip = require('luasnip')
luasnip.snippets = {
  html = {}
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
luasnip.snippets.typescriptreact = luasnip.snippets.html
from_vscode.load({ include = { "html" } })
from_vscode.lazy_load()
luasnip.filetype_extend("typescriptreact", { "html" })
