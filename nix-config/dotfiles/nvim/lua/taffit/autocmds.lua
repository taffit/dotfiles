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

