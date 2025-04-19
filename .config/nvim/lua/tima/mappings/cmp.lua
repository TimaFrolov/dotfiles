local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

return {
  ['<C-y>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }),
  ['<C-n>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    end
  end, { 'i', 's' }),
  ['<C-p>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { 'i', 's' }),
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
}
