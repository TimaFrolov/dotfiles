local comment = require('Comment')
local ft = require('Comment.ft')

vim.keymap.del('n', 'gcc')
vim.keymap.del('n', 'gc')
vim.keymap.del('v', 'gc')

comment.setup({
  padding = true,
  sticky = true,
  ignore = '^$',
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  mappings = {
    basic = true,
    extra = false,
  },
})

ft.set('asm', {'//%s', '/*%s*/'})
