return {
  -- Keep in mind that all lua-files in this directory are loaded by Lazy as well
  {
    'eddyekofo94/gruvbox-flat.nvim',
    config = function() vim.cmd[[colorscheme gruvbox-flat]] end,
  },
  {
    'luukvbaal/nnn.nvim',
    config = function() require('nnn').setup() end
  },

  {
    'declancm/maximize.nvim',
    config = function()
      require('maximize').setup({
      })
      vim.keymap.set({'n', 'i', 'v', 't'}, '<leader><leader>m', '<cmd>lua require("maximize").toggle()<cr>')
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { silent=true, noremap=true, desc='Invoke undotree' })
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  },

  -- :Luapad will open a REPL for testing
  'rafcamlet/nvim-luapad',
  -- :Repl for starting a Lua/VimScript-REPL; type /h for help
  'ii14/neorepl.nvim',

}
