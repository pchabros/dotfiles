local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv("HOME") .. "/.local/dev/vscode-firefox-debug/dist/adapter.bundle.js"}
}
local typescript_config = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node
    -- process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
  {
    name = 'Debug with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
    firefoxExecutable = '/usr/bin/firefox'
  }
}
dap.configurations.typescript = typescript_config
dap.configurations.typescriptreact = typescript_config
require("dapui").setup()
