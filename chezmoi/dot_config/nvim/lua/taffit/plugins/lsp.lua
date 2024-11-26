return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'onsails/lspkind.nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-cmdline'},
    {'L3MON4D3/LuaSnip'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/nvim-cmp'},

    -- Snippets
    {'L3MON4D3/LuaSnip', run = "make install_jsregexp" },
    {'rafamadriz/friendly-snippets'},
  },
  config = function()

    local lsp_zero = require("lsp-zero")
    local caps = vim.lsp.protocol.make_client_capabilities()
    local no_format = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end

    --lsp_zero.preset("lsp-compe") -- produces an error

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local lspkind = require('lspkind')
    cmp.setup({
      preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = 'menu,menuone,preview,noinsert'
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {
          name = 'buffer',
          option = {
            keyword_pattern = [[\k\+]],
          },
          sorting = {
            comparators = {
              function(...) return cmp_buffer:compare_locality(...) end,
              -- The rest of your comparators...
            }
          },
        },
        {
          name = 'path',
        },
      },
      mapping = cmp.mapping.preset.insert({
	-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Esc>'] = cmp.mapping.abort(),
	--['<Tab>'] = cmp_action.tab_complete(),
        --['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        --['<Down>'] = cmp_action.tab_complete(),
        --['<Up>'] = cmp_action.select_prev_or_fallback(),
        ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                         -- can also be a function to dynamically calculate max width such as
                         -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
    
          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item)
            return vim_item
          end
        })
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    --lsp_zero.set_preferences({
      --sign_icons = { }
    --})

    lsp_zero.on_attach(function(client, bufnr)
      local opts = {buffer = bufnr, remap = false}

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)

    lsp_zero.setup()

    require("mason").setup({
      ui = {
          icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
          }
      }
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require("mason-lspconfig").setup({
      ensure_installed = {
        'ts_ls',
        'eslint',
        'lua_ls',
        'pyright',
      },
      capabilities = capabilities,
      handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      },
    })

  end
}
