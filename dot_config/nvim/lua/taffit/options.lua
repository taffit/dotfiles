-- Making the transition a bit easier
local set = vim.opt
local api = vim.api
local cmd = vim.cmd

-- Settings and options
set.encoding = 'utf-8'         -- Set the buffer encoding
set.fileencoding = 'utf-8'     -- Set the file encoding
set.autoindent = true             -- always set autoindenting on
set.copyindent = true            -- copy the previous indentation on autoindenting
set.number = true                 -- Turn on line numbering. Turn it off with "set nonu"
set.tabstop = 2              -- a tab is x spaces
set.shiftwidth = 2           -- indents will have a width of x characters
set.softtabstop = 2          -- sets the number of columns for a TAB
set.expandtab = true              -- always use spaces instead of tab characters
set.shiftround = true             -- use multiple of shiftwidth when indenting with '<' and '>'
--set.listchars = 'eol:⏎,tab:»·,trail:×,nbsp:•'  -- make tab, etc visible
--set.listchars = 'trail:·,precedes:«,extends:»,eol:¬,tab:\|\·'
--set.listchars = 'tab:\\U0001f892·,trail:\\u2716,precedes:«,extends:»,eol:¬,nbsp:•'
--set.listchars = 'tab:\\U0001f892·,trail:\\u2716,precedes:«,extends:»,eol:¶,nbsp:•'
set.listchars = 'tab:\\u21e5\\ ,trail:\\u00d7,precedes:«,extends:»,eol:¶,space:·,nbsp:␣'

set.history = 1000           -- bigger history
set.scrolloff = 8            -- keeping more context on scrolling outside
set.ruler = true                  -- enabling the ruler in the lower right (line, col, %)
set.visualbell = true              -- enabling visual bell instead of bell
set.background = 'dark'        -- Set a dark background
set.wrap = true                -- Wrap long lines
set.breakindent = true                -- Preserve indentation of virtual lines (if `wrap` is enabled)
--set.clipboard = set.clipboard + 'unnamed'
set.clipboard = 'unnamedplus'  -- Use clipboard for unnamed register

-- Search settings
set.ignorecase = true             -- Case insensitive search
set.smartcase = true             -- Smart case search
set.hlsearch = true               -- Highlight search, usable with the highlightning toggling as shortcut
set.incsearch = true              -- show search matches as you type
set.wrapscan = true               -- Wrap search on EOF to BOF
set.mouse = 'a'                -- Mouse support for all modes
set.undofile = true               -- Keep the undo information
set.undodir = vim.fn.stdpath('config') .. '/undodir'  -- Undodir withing XDG_CONFIG_DATA
set.tabpagemax = 15          -- Increase maximum number of possible tabs

-- Look in the directory containing the current file (.), then the current
-- directory (empty text between two commas), then each directory under the
-- current directory ('**').
set.path = '.,,**'
-- TODO: Commenting for now, as after the upgrade to 0.10.0 this results in an error
-- (although working with `set shellslash`)
--set.shellslash = true

-- Row length column
set.colorcolumn = '80'
-- TODO Highlightning should inverse the fg, let's see, if using a theme works as expected
--api.nvim_set_hl(0, 'ColorColumn', { bg = 'gray', fg = inverse })

-- Creating splits on the right or below
set.splitbelow = true
set.splitright = true

set.formatoptions:append('j')  -- Remove comment character when joining lines
-- Alternative for adding an option to an existing beside the :append()-function:
-- set.formatoptions = vim.opt.formatoptions + 'j'

set.guifont = 'Fira Code'
set.conceallevel = 3

set.completeopt = 'menu,menuone,noselect'
set.wildignore = '*/node_modules/**'
set.wildmenu = true
set.wildmode = 'lastused:list:full'


-- TODO


