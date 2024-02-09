return {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup("~/.config/local/share/nvim/mason/packages/debugpy/venv/bin/python")
    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "attach",
      name = "Django",
      port = 5678,
      host = "127.0.0.1",
      mode = "remote",
      cwd = vim.fn.getcwd(),
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/manage.py",
          remoteRoot = "/app/manage.py",
        },
      },
    })
  end,
}
