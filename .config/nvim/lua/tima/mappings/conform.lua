return {
  { '<leader>ff', function() require('conform').format({ lsp_fallback = true, async = true }) end, mode = { 'n', 'v' }, desc = '[F]ile [F]ormat' }
}
