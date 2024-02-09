return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dockerfile",
        "javascript",
        "jsonc",
        "lua",
        "python",
        "typescript",
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      highligh = {
        enable = true,
      },
      additional_vim_regex_highlighting = true,
    },
  },
}
