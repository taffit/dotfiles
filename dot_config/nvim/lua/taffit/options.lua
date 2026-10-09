local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.number = true
opt.relativenumber = false
opt.autoindent = true
opt.copyindent = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.breakindent = true
opt.wrap = true
opt.history = 1000
opt.ruler = true
opt.visualbell = true
opt.background = "dark"
opt.scrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrapscan = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true
opt.listchars = {
  tab = "⇥ ",
  trail = "×",
  precedes = "«",
  extends = "»",
  eol = "¶",
  space = "·",
  nbsp = "␣",
}
opt.colorcolumn = "80"
opt.tabpagemax = 15
opt.conceallevel = 3
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildignore:append({ "*/node_modules/**" })
opt.wildmenu = true
opt.wildmode = { "lastused", "list", "full" }
opt.path = { ".", "", "**" }
opt.formatoptions:append("j")
