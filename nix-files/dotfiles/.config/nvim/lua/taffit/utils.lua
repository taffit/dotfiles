-- See: https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
local M = {}

-- `source`-friendly loading function for lua-files
-- Source: https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/
function M.load(mod)
  package.loaded[mod] = nil
  require(mod)
end

function M.map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  -- keymap.set is better than nvim_set_keymap, as you can use multiple modes
	-- and functions in your maps as well
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Source: https://www.reddit.com/r/neovim/comments/vbf609/comment/id5tbuz/
function M.toggle_option(opt, on, off, name)
	local message = name
	if vim.opt[opt]:get() == off then
		vim.opt[opt] = on
		message = message .. " enabled"
	else
		vim.opt[opt] = off
		message = message .. " disabled"
	end
	vim.notify(message)
end

-- Adjusted from https://github.com/ddrscott/config-nvim/
-- Will jump to the second position if there was no movement for the first command
function M.toggle_movement(firstOp, thenOp)
  local pos = vim.api.nvim_win_get_cursor(0)  -- Get position in current window
  local c = vim.v.count > 0 and vim.v.count or ''  -- Check if there is a count provided
  vim.cmd(":normal! " .. c .. firstOp ..'<cr>')  -- Execute firstOp ...
  local new_pos = vim.api.nvim_win_get_cursor(0)  -- ... and get position again
  if pos[1]==new_pos[1] and pos[2]==new_pos[2] then  -- Check if there was some movement
    vim.cmd(":normal! " .. c .. thenOp ..'<cr>')
  end
  --vim.notify('Old pos: ' ..vim.inspect(pos)..'; new pos: '..vim.inspect(new_pos)..'; eq: '..(vim.inspect(pos[1]==new_pos[1] and pos[2]==new_pos[2]))..'; thenOp: '..":normal! " .. c .. thenOp ..'<cr>')
end

-- Merges table(s) into the result-table
-- See: https://www.reddit.com/r/lua/comments/rtiedd/comment/hqt1zo2/?utm_source=share&utm_medium=web2x&context=3
function M.tableMerge(result, ...)
  for _, t in ipairs({...}) do
    for _, v in ipairs(t) do
      -- Should be faster than table.insert(result, v)
      --result[counter] = v
      table.insert(result, v)
    end
  end
end

return M
