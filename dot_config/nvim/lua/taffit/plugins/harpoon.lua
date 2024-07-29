return {
  {
    'theprimeagen/harpoon',
    config = function()
      -- require('harpoon').setup({})
      local map = require('taffit.utils').map
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')
      map('n', '<leader>a', mark.add_file, { desc='Add file to the harpoon-list' })
      map('n', '<leader>h', ui.toggle_quick_menu, { desc='Toggle harpoon UI' })

      -- For selecting file 1..4
      -- map('n', '<C-1>', function() ui.nav_file(1) end)

      -- Registering harpoon as a telescope-extension
      require('telescope').load_extension('harpoon')
      map('n', '<leader>fh', '<cmd>Telescope harpoon marks<cr>', {})
    end,
  }
}
