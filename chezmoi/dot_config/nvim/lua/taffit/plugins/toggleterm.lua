local map = require('taffit.utils').map

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require("toggleterm").setup
    {
      open_mapping = [[<leader><leader>t]],
    }
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      map('t', '<esc>', [[<C-\><C-n>]], opts)
      map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Open terminal with provided directions
    map({'n', 'v', 't'}, '<leader><leader>th', '<cmd>exe v:count1 . "ToggleTerm direction=horizontal"<cr>', {})
    map({'n', 'v', 't'}, '<leader><leader>tv', '<cmd>exe v:count1 . "ToggleTerm direction=vertical"<cr>', {})
    map({'n', 'v', 't'}, '<leader><leader>tf', '<cmd>exe v:count1 . "ToggleTerm direction=float"<cr>', {})
    map({'n', 'v', 't'}, '<leader>t', '<cmd>exe v:count1 . "ToggleTerm direction=float"<cr>', {})

    -- Terminal mode mapping to close current terminal
    map('t', '<leader><leader>tc', '<cmd>ToggleTerm<cr>', {})
  end,
}

