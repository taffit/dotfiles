local api = vim.api

-- windows to close with "q"
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
api.nvim_create_autocmd(
  "FileType",
  { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] }
)

-- Close netrw window so it doesn't show up in the buffer list
-- See: https://vi.stackexchange.com/a/14633
api.nvim_create_autocmd(
  "FileType",
  { pattern = "netrw", command = [[setl bufhidden=wipe]] }
)
-- If in netrw, q closes the window
api.nvim_create_autocmd(
  "FileType",
  { pattern = "netrw", command = [[nnoremap q :bw<cr>]] }
)

-- Change working directory to path of current buffer
api.nvim_create_autocmd(
  "BufEnter",
  { pattern = '*',
    command = [[silent! lcd %:p:h:gs/ /\\ /]]
  }
)


-- Check if we need to reload the file when it changed
api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

-- Hopefully solving the copy/paste-problem on WSL
-- Encoding with PowerShell doesn't work, so e. g. German Umlauts become ü=<o81> or similar.
if vim.fn.has("wsl") then
  vim.g.clipboard = {
    name = "WslClipboard (win32yank.exe)",
    copy = {
      -- ["+"] = "clip.exe",
      -- ["*"] = "clip.exe",
      ["+"] = "win32yank.exe -i",
      ["*"] = "win32yank.exe -i",
    },
    -- Source: https://neovim.io/doc/user/provider.html#clipboard-wsl
    paste = {
      -- ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      -- ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["+"] = 'win32yank.exe -o --lf',
      ["*"] = 'win32yank.exe -o --lf',
    -- Source: https://github.com/neovim/neovim/issues/19204
    },
    cache_enabled = true,
  }
end

-- Another method pasted (and commented out) below.
-- if vim.fn.has('wsl') == 1 then
--     vim.api.nvim_create_autocmd('TextYankPost', {
--         group = vim.api.nvim_create_augroup('Yank', { clear = true }),
--         callback = function()
--             vim.fn.system('clip.exe', vim.fn.getreg('"'))
--         end,
--     })
-- end
