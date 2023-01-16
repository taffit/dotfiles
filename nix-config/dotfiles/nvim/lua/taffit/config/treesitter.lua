require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  -- Will be checked during startup!
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"elixir",
		"graphql",
		"help",
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
	},
	-- List of parsers to ignore installing (for "all")
	ignore_install = {},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
	  enable = true,

	  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	  -- Using this option may slow down your editor, and you may see some duplicate highlights.
	  -- Instead of true it can also be a list of languages.
	  additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			-- Languages that have a single comment style
			typescript = "// %s",
			css = "/* %s */",
			scss = "/* %s */",
			html = "<!-- %s -->",
			svelte = "<!-- %s -->",
			vue = "<!-- %s -->",
			json = "",
		},
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"svelte",
			"typescript",
			"xml",
		},
	},
}
