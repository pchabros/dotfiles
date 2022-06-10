local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end

local packer = require("packer")
local use = packer.use

return require("packer").startup(
  function()
    -- use({ "/home/kris/WorkingDirectory/rhino.nvim" })
    -- use({ 'tjdevries/nlua.nvim' })
    -- use({ 'rafcamlet/nvim-luapad' })
    -- use({ 'stevearc/dressing.nvim' })
    -- use({ 'rcarriga/nvim-notify' })
    -- use({ 'euclidianAce/BetterLua.vim' })
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "moll/vim-bbye" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-eunuch" })
    use({ "lilydjwg/colorizer" })
    use({ "christoomey/vim-tmux-navigator" })
    use({ "nvim-treesitter/nvim-treesitter" })
    use({ "hrsh7th/nvim-cmp", requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    }})
    use({
      'saadparwaiz1/cmp_luasnip',
      after = 'nvim-cmp',
      requires = {
        'L3MON4D3/LuaSnip',
        {
          'rafamadriz/friendly-snippets',
          after = 'cmp-vsnip'
        }
      }
    })
    use({ "rafamadriz/friendly-snippets"})
    use({ "tpope/vim-fugitive" })
    use({ "airblade/vim-gitgutter" })
    use({ "idanarye/vim-merginal" })
    use({ "mfussenegger/nvim-dap" })
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "onsails/lspkind-nvim" })
    use({ "neovim/nvim-lspconfig" })
    use({ "tami5/lspsaga.nvim" })
    use({ "windwp/nvim-autopairs" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "arcticicestudio/nord-vim" })
    use({ "b3nj5m1n/kommentary" })
    use({ "tpope/vim-obsession" })
    use({ "tomlion/vim-solidity" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
    use({ "MunifTanjim/prettier.nvim" })
    use({ "gbprod/cutlass.nvim" })
    use({ "norcalli/nvim-terminal.lua" })
    use({ "nvim-lualine/lualine.nvim" })
    use({ "kdheepak/tabline.nvim" })
    use({ "sunjon/shade.nvim" })
    use({ 'declancm/cinnamon.nvim' })
    use({ 'jpalardy/vim-slime' })
    use({ 'lukas-reineke/indent-blankline.nvim' })
    --[[ use({ 'neoclide/vim-jsx-improve' })
    use({ 'sheerun/vim-polyglot' }) ]]
    use({
      "AckslD/nvim-neoclip.lua",
      requires = {
        { "tami5/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
        { "ibhagwan/fzf-lua" },
      },
      config = function()
        require("neoclip").setup({})
      end,
    })
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    })
    use({
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim"
    })
    use({ "NTBBloodbath/rest.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "phaazon/hop.nvim", as = "hop" })
  end,
  {
    display = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    }
  }
)
