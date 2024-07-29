local function maximize_status()
  return vim.t.maximized and '  ' or ''
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'gruvbox-flat',
        --theme = 'auto',
        icons_enabled = true,
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        globalstatus = false,
      },

      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', maximize_status},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },

      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end
}
