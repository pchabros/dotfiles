return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dockerfile", "lua", "javascript", "typescript", "python" },
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
