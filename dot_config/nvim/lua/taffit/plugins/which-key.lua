return {
  'folke/which-key.nvim',
  enabled = false,  -- TODO annoying as it popped up in insert-mode on every <space>
  config = function()
    --vim.o.timeout = true
    --vim.o.timeoutlen = 300
    require('which-key').setup {
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { " ", "j", "k" },
        v = { "j", "k" },
      },
    }
  end,
}
