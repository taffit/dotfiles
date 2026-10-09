local group = vim.api.nvim_create_augroup("taffit", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "man",
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "netrw",
  callback = function(event)
    vim.bo[event.buf].bufhidden = "wipe"
    vim.keymap.set("n", "q", "<cmd>bwipeout<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  command = [[silent! lcd %:p:h:gs/ /\ ]],
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  command = "checktime",
})

if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard (win32yank.exe)",
    copy = {
      ["+"] = "win32yank.exe -i",
      ["*"] = "win32yank.exe -i",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = true,
  }
end
