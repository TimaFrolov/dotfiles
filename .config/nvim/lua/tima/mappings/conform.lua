local conform = require 'conform'

vim.keymap.set({ "n", "v" }, "<leader>ff", function() conform.format({ lsp_fallback = true, async = true }) end)
