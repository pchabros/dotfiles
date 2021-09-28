local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

local packer = require("packer")
local use = packer.use

return require("packer").startup(
  function()
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "moll/vim-bbye" })
    use({ "chrisbra/Colorizer" })
    use({ "christoomey/vim-tmux-navigator" })
    use({ "arcticicestudio/nord-vim" })
    use({ "nvim-treesitter/nvim-treesitter" })
    use({ "hrsh7th/nvim-cmp", requires = { { 
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    } } })
    use({ "mfussenegger/nvim-dap" })
    use({ "scalameta/nvim-metals" })
    use({ "neovim/nvim-lspconfig" })
    use({ "glepnir/lspsaga.nvim" })
    use({ "windwp/nvim-autopairs" })
    use({
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    })
    use({ "b3nj5m1n/kommentary" })
    use({ "tpope/vim-obsession" })
    use({
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    })
    use({
      'phaazon/hop.nvim',
      as = 'hop',
      config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    })
  end,
  {
    display = {
      border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
    }
  }
)
