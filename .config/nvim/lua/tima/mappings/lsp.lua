local lsp = require 'lsp-zero'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local telescope = require("telescope.builtin")

local has_words_before = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local swap_inlay_hints = (function()
  local hints = false

  local swap = function()
    hints = not hints
    for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
      vim.lsp.inlay_hint.enable(bufnr, hints)
    end
  end

  local autocmd = function()
    vim.lsp.inlay_hint.enable(0, hints)
  end

  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, { callback = autocmd })

  return swap
end)()

vim.keymap.set("n", "<leader>fR", ":LspRestart<cr>", { desc = "[R]estart LSP client" })
vim.keymap.set("n", "<leader>fI", ":LspInfo<cr>", { desc = "Show LSP client [I]nfo" })
vim.keymap.set("n", "<leader>fL", ":LspLog<cr>", { desc = "Show LSP client [L]og" })

vim.keymap.set("n", "<leader>fh", swap_inlay_hints, { desc = "Toggle inlay [H]ints" })
vim.keymap.set("n", "<leader>fr", vim.lsp.buf.rename, { desc = "[R]ename lsp symbol" })
vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, { desc = "Show code [A]ctions" })
vim.keymap.set("n", "<leader>fs", ":ClangdSwitchSourceHeader<cr>", { desc = "[S]witch source/header" })
vim.keymap.set("n", "<leader>fc", vim.lsp.codelens.refresh, { desc = "Refresh LSP [C]odelens" })

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

cmp.setup({
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "crates" },
  },
  mapping = cmp_mappings,
})

vim.keymap.set('n', 'gr', telescope.lsp_references, { desc = "[G]o to [R]eferences" })
vim.keymap.set('n', 'gd', telescope.lsp_definitions, { desc = "[G]o to [D]efinitions" })
vim.keymap.set('n', 'go', telescope.lsp_type_definitions, { desc = "[GO] to type definitions" })
vim.keymap.set('n', 'gi', telescope.lsp_implementations, { desc = "[G]o to [I]mplementations" })

return {
  omit = { 'gr', 'gd', 'go', 'gi' },
}
