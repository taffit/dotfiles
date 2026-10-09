local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function toggle_option(opt, on, off, name)
  if vim.opt[opt]:get() == off then
    vim.opt[opt] = on
    vim.notify(name .. " enabled")
  else
    vim.opt[opt] = off
    vim.notify(name .. " disabled")
  end
end

local function toggle_movement(first, second)
  local pos = vim.api.nvim_win_get_cursor(0)
  local count = vim.v.count > 0 and vim.v.count or ""
  vim.cmd("normal! " .. count .. first)
  local new_pos = vim.api.nvim_win_get_cursor(0)
  if pos[1] == new_pos[1] and pos[2] == new_pos[2] then
    vim.cmd("normal! " .. count .. second)
  end
end

map({ "n", "v" }, "<Space>", "<Nop>", opts)

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>x", "<cmd>confirm qall<cr>", { desc = "Quit all" })
map("n", "<cr>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader><leader>a", "<cmd>keepjumps normal! ggVG<cr>", { desc = "Select all" })
map("n", "<leader><leader>s", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })
map("n", "<leader>rf", "<cmd>edit<cr>", { desc = "Reload current buffer" })
map("n", "<leader>cd", "<cmd>cd %:p:h<cr><cmd>pwd<cr>", { desc = "Change cwd to current file" })
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true, silent = false, desc = "Substitute word under cursor" })

map({ "n", "v" }, "n", "nzz", { desc = "Next search result centered" })
map({ "n", "v" }, "N", "Nzz", { desc = "Previous search result centered" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump back centered" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward centered" })
map("n", "j", "gj", { desc = "Move down by display line" })
map("n", "k", "gk", { desc = "Move up by display line" })

map("n", "<leader><leader>b", ":ls<cr>:b<space>", { silent = false, desc = "Choose buffer" })
map("n", "<leader>ls", "<cmd>ls<cr>", { desc = "List buffers" })
map("n", "<leader>bb", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>nn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>wq", "<C-w>q", { desc = "Close window" })
map({ "n", "v", "s" }, "<leader><leader>v", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map({ "n", "v", "s" }, "<leader><leader>h", "<cmd>split<cr>", { desc = "Horizontal split" })
map({ "n", "v", "s" }, "<leader><leader>=", "<C-w>=", { desc = "Equalize windows" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "oo", "o<esc>k", { desc = "Insert blank line below" })
map("n", "OO", "O<esc>j", { desc = "Insert blank line above" })
map("n", "x", '"_x', { desc = "Delete char without yanking" })
map("n", "X", '"_x', { desc = "Delete char without yanking" })
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })
map("x", "p", "pgvy", { desc = "Paste and keep pasted text selected" })
map("x", "P", "Pgvy", { desc = "Paste before and keep pasted text selected" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("n", "<A-j>", "<cmd>move .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>move .-2<cr>==", { desc = "Move line up" })
map("x", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "Move selection down" })
map("x", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "Move selection up" })

map({ "n", "v", "t" }, "<C-j>", "<C-w>w", { desc = "Jump to next window" })
map({ "n", "v", "t" }, "<C-k>", "<C-w>W", { desc = "Jump to previous window" })
map({ "n", "v", "t" }, "<C-h>", "<C-w><C-h>", { desc = "Jump to left window" })
map({ "n", "v", "t" }, "<C-l>", "<C-w><C-l>", { desc = "Jump to right window" })
map({ "n", "v", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "v", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "v", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "v", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map({ "n", "i" }, "<leader><leader>l", function()
  toggle_option("list", true, false, "List")
end, { desc = "Toggle list hidden chars" })
map({ "n", "i" }, "<leader><leader>p", function()
  toggle_option("paste", true, false, "Paste")
end, { desc = "Toggle paste mode" })
map("n", "0", function()
  toggle_movement("^", "0")
end, { desc = "Toggle line start / first nonblank" })
map("n", "^", function()
  toggle_movement("0", "^")
end, { desc = "Toggle first nonblank / line start" })
map("n", "$", function()
  toggle_movement("$", "^")
end, { desc = "Toggle line end / first nonblank" })
