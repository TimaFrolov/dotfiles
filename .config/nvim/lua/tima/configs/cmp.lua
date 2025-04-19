local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
      -- TODO: check out native neovim snippets
      -- vim.snippet.expand(args.body)
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = require('tima.mappings.cmp'),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'crates' },
      { name = 'lazydev', group_index = 0 }
    },
    { { name = 'buffer' } }
  )
})
