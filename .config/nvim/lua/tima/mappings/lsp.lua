local swap_inlay_hints = (function()
  local hints = false

  local swap = function()
    hints = not hints
    for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
      vim.lsp.inlay_hint.enable(hints, { bufnr = bufnr })
    end
  end

  local autocmd = function()
    vim.lsp.inlay_hint.enable(hints, { bufnr = nil })
  end

  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, { callback = autocmd })

  return swap
end)()


return {
  { "<leader>fR", ":LspRestart<cr>",                                                  desc = "[R]estart LSP client",     silent = true },
  { "<leader>fI", ":LspInfo<cr>",                                                     desc = "Show LSP client [I]nfo",   silent = true },
  { "<leader>fL", ":LspLog<cr>",                                                      desc = "Show LSP client [L]og",    silent = true },
  { "<leader>fh", swap_inlay_hints,                                                   desc = "Toggle inlay [H]ints" },
  { "<leader>fr", vim.lsp.buf.rename,                                                 desc = "[R]ename lsp symbol" },
  { "<leader>fa", vim.lsp.buf.code_action,                                            desc = "Show code [A]ctions" },
  { "<leader>fs", ":ClangdSwitchSourceHeader<cr>",                                    desc = "[S]witch source/header",   silent = true },
  { "<leader>fc", vim.lsp.codelens.refresh,                                           desc = "Refresh LSP [C]odelens" },
  { 'gr',         function() require("telescope.builtin").lsp_references() end,       desc = "[G]o to [R]eferences" },
  { 'gd',         function() require("telescope.builtin").lsp_definitions() end,      desc = "[G]o to [D]efinitions" },
  { 'go',         function() require("telescope.builtin").lsp_type_definitions() end, desc = "[GO] to type definitions" },
  { 'gi',         function() require("telescope.builtin").lsp_implementations() end,  desc = "[G]o to [I]mplementations" },
}
