return {
  { "<leader>sf", function() require("telescope.builtin").find_files() end,            desc = "[S]earch for [F]iles" },
  { "<leader>sg", function() require("telescope.builtin").live_grep() end,             desc = "[S]earch via [G]rep" },
  { "<leader>sb", function() require("telescope.builtin").buffers() end,               desc = "[S]earch for [B]uffers" },
  { "<leader>sd", function() require("telescope.builtin").lsp_document_symbols() end,  desc = "[S]earch for [D]ocument LSP symbols" },
  { "<leader>sp", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "[S]earch for [P]roject LSP symbols" },
  { "<leader>se", function() require("telescope.builtin").diagnostics() end,           desc = "[S]earch for [E]rrors" },
  { "<leader>sm", function() require("telescope.builtin").marks() end,                 desc = "[S]earch for [M]arks" },
  { "<leader>sk", function() require("telescope.builtin").keymaps() end,               desc = "[S]earch for [K]eymaps" },
  { "<leader>sh", function() require("telescope.builtin").help_tags() end,             desc = "[S]earch for [H]elp tags" },
}
