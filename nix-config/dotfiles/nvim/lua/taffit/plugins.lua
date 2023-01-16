-- [[ Packer as package manager ]]
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'  -- Let packer handle itself
	use {
	  'eddyekofo94/gruvbox-flat.nvim',
	  config = function() vim.cmd[[colorscheme gruvbox-flat]] end,
  }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('taffit.config.lualine')
		end,
	}
	use {
		'luukvbaal/nnn.nvim',
		config = function() require('nnn').setup() end
	}
	use {
		'declancm/maximize.nvim',
		config = function()
		  require('maximize').setup({
		    default_keymaps = false,
      })
      vim.keymap.set({'n', 'i', 'v', 't'}, '<leader><leader>m', '<cmd>lua require("maximize").toggle()<cr>')
		end,
	}
  use {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { silent=true, noremap=true, desc='Invoke undotree' })
    end,
  }

  use {
    'theprimeagen/harpoon',
    config = function() require('taffit.config.harpoon') end,
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                          , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require('taffit.config.telescope') end,
  }

	-- Unified highlight for all filetypes
	use { 
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("taffit.config.treesitter")
		end,
		run = ":TSUpdate",
	}
	use {
	  'numToStr/Comment.nvim',
	  config = function() require('Comment').setup() end,
	}
	use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  },
	  config = function() require('taffit.config.lsp') end,
  }
	
	use {
		'folke/which-key.nvim',
		disable = true,  -- TODO annoying as it popped up in insert-mode on every <space>
		config = function()
      --vim.o.timeout = true
      --vim.o.timeoutlen = 300
			require('config.which-key')
		end,
	}

  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function() require('taffit.config.toggleterm') end,
  }

  -- :Luapad will open a REPL for testing
  use 'rafcamlet/nvim-luapad'
  -- :Repl for starting a Lua/VimScript-REPL; type /h for help
  use 'ii14/neorepl.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
