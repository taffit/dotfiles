return { 
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require'nvim-treesitter.config'.setup {
      -- A list of parser names, or "all"
      -- Will be checked during startup!
      ensure_installed = {
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
      },
      -- List of parsers to ignore installing (for "all")
      ignore_install = {},
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      highlight = {
        enable = true,

        disable = function(lang, buf)
          -- You can also use `vim.api.nvim_buf_line_count(buf)` if you want to use the LOC as measure
          local max_filesize = 100 * 1024 -- 100 KB
          local js_max_filesize = 50 * 1024 -- 50 KB
          local sql_max_filesize = 100 * 1024 -- 50 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and (stats.size > max_filesize or (lang == "js" and stats.size > js_max_filesize) or (lang == "sql" and stats.size > sql_max_filesize)) then
            return true
          end
        end,

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
  end,
  build = ":TSUpdate",
}
