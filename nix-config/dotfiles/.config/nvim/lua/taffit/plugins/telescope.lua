return {
  'nvim-telescope/telescope.nvim',--, version = '0.1.6',
  -- or                          , branch = '0.1.x',
  dependencies = { {'nvim-lua/plenary.nvim'} },
  config = function()
    local map = require('taffit.utils').map
    local builtin = require('telescope.builtin')

    -- require('telescope').setup{
    --   defaults = {
    --     mappings = {
    --       i = {
    --         [‘<esc>’] = require(‘telescope.actions’).close,
    --       }
    --     }
    --   },
    -- }
    local actions = require("telescope.actions")
    require("telescope").setup{
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },
      }
    }

    map('n', '<leader>ff', builtin.find_files, {})
    map('n', '<leader>fg', builtin.git_files, {})
    map('n', '<leader>fb', builtin.buffers, {})
    map('n', '<leader>fr', builtin.live_grep, {})
    map('n', '<leader>fo', builtin.oldfiles, {})
    --map('n', '<leader>fh', builtin.help_tags, {})
  end
}
