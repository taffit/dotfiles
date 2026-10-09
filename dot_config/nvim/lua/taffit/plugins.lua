-- Neovim 0.12 includes vim.pack. Keep third-party plugins minimal and
-- declare them here only after deciding each one is worth carrying.
local plugins = {
  { src = "https://github.com/eddyekofo94/gruvbox-flat.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/declancm/maximize.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/luukvbaal/nnn.nvim" },
}

if not vim.pack then
  error("This Neovim config requires Neovim 0.12 or newer because it uses vim.pack")
end

vim.pack.add(plugins)

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update vim.pack plugins" })

vim.api.nvim_create_user_command("PackUpdateForce", function()
  vim.pack.update(nil, { force = true })
end, { desc = "Update vim.pack plugins without confirmation" })

vim.cmd.colorscheme("gruvbox-flat")

require("maximize").setup()
vim.keymap.set({ "n", "i", "v", "t" }, "<leader><leader>m", function()
  require("maximize").toggle()
end, { desc = "Toggle maximize window" })

require("toggleterm").setup({
  open_mapping = [[<leader><leader>t]],
})

local function set_terminal_keymaps(event)
  local terminal_opts = { buffer = event.buf }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], terminal_opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], terminal_opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], terminal_opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], terminal_opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], terminal_opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = set_terminal_keymaps,
})

vim.keymap.set({ "n", "v", "t" }, "<leader><leader>th", '<cmd>exe v:count1 . "ToggleTerm direction=horizontal"<cr>', { desc = "Toggle horizontal terminal" })
vim.keymap.set({ "n", "v", "t" }, "<leader><leader>tv", '<cmd>exe v:count1 . "ToggleTerm direction=vertical"<cr>', { desc = "Toggle vertical terminal" })
vim.keymap.set({ "n", "v", "t" }, "<leader><leader>tf", '<cmd>exe v:count1 . "ToggleTerm direction=float"<cr>', { desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "v", "t" }, "<leader>t", '<cmd>exe v:count1 . "ToggleTerm direction=float"<cr>', { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<leader><leader>tc", "<cmd>ToggleTerm<cr>", { desc = "Close terminal" })

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = telescope_actions.close,
      },
    },
  },
})

vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "Find old files" })

require("nnn").setup()
vim.keymap.set({ "n", "v", "x" }, "<leader>o", "<cmd>NnnPicker<cr>", { desc = "Open nnn picker" })

local treesitter_languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "elixir",
  "graphql",
  "vimdoc",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "php",
  "python",
  "regex",
  "rust",
  "sql",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local installed_treesitter_parsers = {}
for _, parser in ipairs(require("nvim-treesitter").get_installed("parsers")) do
  installed_treesitter_parsers[parser] = true
end
local missing_treesitter_parsers = vim.tbl_filter(function(parser)
  return not installed_treesitter_parsers[parser]
end, treesitter_languages)
if #missing_treesitter_parsers > 0 then
  local install_task = require("nvim-treesitter").install(missing_treesitter_parsers)
  if #vim.api.nvim_list_uis() == 0 then
    install_task:wait(300000)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_languages,
  callback = function(event)
    local max_filesize = 100 * 1024
    local smaller_max_files = { javascript = 50 * 1024, sql = 100 * 1024 }
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > (smaller_max_files[event.match] or max_filesize) then
      return
    end
    pcall(vim.treesitter.start)
    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local lsp_servers = { "ts_ls", "eslint", "lua_ls", "pyright" }
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
  automatic_enable = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local lsp_opts = { buffer = event.buf, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, lsp_opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, lsp_opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, lsp_opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, lsp_opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, lsp_opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, lsp_opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, lsp_opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts)
  end,
})

require("lualine").setup({
  options = {
    theme = "gruvbox-flat",
    icons_enabled = true,
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
