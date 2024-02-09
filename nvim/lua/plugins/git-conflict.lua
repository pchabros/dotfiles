return {
  "akinsho/git-conflict.nvim",
  version = "v1.0.0",
  config = true,
  opts = {
    default_mappings = false,
    default_commands = true,
    disable_diagnostics = true,
    list_opener = "copen",
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
}
