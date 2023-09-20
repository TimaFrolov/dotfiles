local lsp = require 'lsp-zero'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local telescope = require("telescope.builtin")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.keymap.set("n", "<leader>pr", ":LspRestart<cr>")

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
  },
  mapping = cmp_mappings,
})

vim.keymap.set('n', 'gr', telescope.lsp_references)
vim.keymap.set('n', 'gd', telescope.lsp_definitions)
vim.keymap.set('n', 'go', telescope.lsp_type_definitions)
vim.keymap.set('n', 'gi', telescope.lsp_implementations)

return {
  omit = { 'gr', 'gd', 'go', 'gi' },
}
