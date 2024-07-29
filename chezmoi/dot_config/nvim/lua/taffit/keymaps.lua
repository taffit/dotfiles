local map = require('taffit.utils').map
local toggle_option = require('taffit.utils').toggle_option
local toggle_movement = require('taffit.utils').toggle_movement
local opts = { noremap=true, silent=true }
local silent = { silent=true }

-- Set the <leader> to <Space>
map('n', '<space>', '<nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
-- normal_mode = 'n',
-- insert_mode = 'i',
-- visual_mode = 'v',
-- visual_block_mode = 'x',
-- term_mode = 't',
-- command_mode = 'c',

-- Removes the highlightning of a search term (and removes the :noh in the status)
map('n', '<cr>', ':noh<cr>:<backspace>')
map('n', '<leader>w', '<cmd>write<cr>')  -- Save file
map('n', '<leader><leader>a', ':keepjumps normal! ggVG<cr>')  -- Select all

-- An example of a user-defined function
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
map('n', '<leader><leader>s', ':ReloadConfig<cr>')  -- Source $MYVIMRC (using user defined function)
-- Center screen on previous/next-selection
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')
map('n', '<C-o>', '<C-o>zz')
map('n', '<C-i>', '<C-i>zz')

-- if the line wraps, it goes to next line instead of jumping to next row
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Refresh/reload current buffer
map('n', '<leader>rf', ':e<cr>')
-- <leader>cd changes the directory to the one of the current buffer
map('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')
-- Hitting <leader>b will invoke buffers und then you have to select just the number
--:nnoremap <leader>b :buffers<CR>:buffer<Space>
map('n', '<leader><leader>b', ':ls<cr>:b<space>')
-- Just listing the open buffers
map('n', '<leader>ls', ':ls<cr>')
-- Next buffer
map('n', '<leader>bb', ':bprevious<cr>')
-- Next buffer
map('n', '<leader>nn', ':bnext<cr>')
-- Delete the current buffer
map('n', '<leader>bd', ':bdelete<cr>')
-- Just close the window, not the buffer, with <leader>wq
map('n', '<leader>wq', '<C-w>q')
-- Just close it
map('n', '<leader>q', ':q<cr>')
-- Exiting, but asking for saving modified buffers
map('n', '<leader>x', ':confirm qall<cr>')
-- A new vertical split with <leader><leader>v
map({'n', 'v', 's'}, '<leader><leader>v', ':vsplit<cr>')
-- A new horizontal split with <leader><leader>h
map({'n', 'v', 's'}, '<leader><leader>h', ':split<cr>')
-- Reset sizes
map({'n', 'v', 's'}, '<leader><leader>=', '<C-w>=')

-- A more intuitive way: oo or OO
map('n', 'oo', 'o<esc>k')
map('n', 'OO', 'O<esc>j')

-- Prevent x from overriding what's in the clipboard.
map('n', 'x', '"_x')
map('n', 'X', '"_x')
-- Prevent selecting and pasting from overwriting what you originally copied.
map('v', 'p', '"_dP')
map('x', 'p', 'pgvy')
map('x', 'P', 'Pgvy')

-- Easier navigation (TODO as soon as you have tmux activated, we need some other script)
-- Basically using next/previous instead of up/down, spanning multiple columns, ...
map({'n', 'v', 't'}, '<C-j>', '<C-w>w', { desc = 'Jump to the next buffer/buffer below' })
map({'n', 'v', 't'}, '<C-k>', '<C-w>W', { desc = 'Jump to the previous buffer/buffer above' })
--map({'n', 'v', 't'}, '<C-j>', '<C-w><C-j>')
--map({'n', 'v', 't'}, '<C-k>', '<C-w><C-k>')
-- ... and left/right
map({'n', 'v', 't'}, '<C-h>', '<C-w><C-h>', { desc = 'Jump to the buffer to the left' })
map({'n', 'v', 't'}, '<C-l>', '<C-w><C-l>', { desc = 'Jump to the buffer to the right' })

-- Resize with arrows
map({'n', 'v', 't'}, '<C-Up>', ':resize +2<CR>', opts)
map({'n', 'v', 't'}, '<C-Down>', ':resize -2<CR>', opts)
map({'n', 'v', 't'}, '<C-Left>', ':vertical resize -2<CR>', opts)
map({'n', 'v', 't'}, '<C-Right>', ':vertical resize +2<CR>', opts)

-- Stay in visual mode even if indenting
-- TODO Check if these lines are the reason that the dot-operator doesn't work in visual mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Navigate buffers
map('n', '<S-l>', '<cmd>bnext<cr>', opts)
map('n', '<S-h>', '<cmd>bprevious<cr>', opts)
--map('n', '<leader>bn', ':bn<cr>')
--map('n', '<leader>bp', ':bp<cr>')

-- Move text up and down
map('n', '<A-j>', '<Esc>:m .+1<CR>==', opts)
map('n', '<A-k>', '<Esc>:m .-2<CR>==', opts)
-- map('v', '<A-j>', ":m '>+1<CR>gv==gv", opts)
-- map('v', '<A-k>', ":m '<-2<CR>gv==gv", opts)
map('x', '<A-j>', ":move '>+1<CR>gv=gv", opts)
map('x', '<A-k>', ":move '<-2<CR>gv=gv", opts)

-- Terminal mappings
-- Using ToggleTerm-plugin instead
--map('n', '<leader><leader>t', ':term<cr>')  -- open
map('t', '<esc>', '<C-\\><C-n>')                    -- exit

-- File explorer, using nnn.vim
--map({'n', 'v', 'x'}, '<leader><leader>e', ':NnnExplorer<cr>', opts)
map({'n', 'v', 'x'}, '<leader>o', ':NnnPicker<cr>', opts)

map({'n', 'i'}, '<leader><leader>l', function() toggle_option("list", true, false, "List") end, { desc = "Toggle list hidden chars"})
map({'n', 'i'}, '<leader><leader>p', function() toggle_option("paste", true, false, "Paste") end, { desc = "Toggle paste mode"})

-- 0 .. Jump to first non-empty character on line. On a second press to the beginning
map('n', '0', function() toggle_movement('^', '0') end, opts)
map('n', '^', function() toggle_movement('0', '^') end, opts)
map('n', '$', function() toggle_movement('$', '^') end, opts)


-- "Snippet" for substitute the word under the cursor
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { silent=false, noremap=true, desc='Substitute the word under the cursor' })
