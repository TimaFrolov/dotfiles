local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", telescope.find_files)
vim.keymap.set("n", "<leader>sg", telescope.live_grep)
vim.keymap.set("n", "<leader>sb", telescope.buffers)
vim.keymap.set("n", "<leader>sd", telescope.lsp_document_symbols)
vim.keymap.set("n", "<leader>sp", telescope.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>se", telescope.diagnostics)
