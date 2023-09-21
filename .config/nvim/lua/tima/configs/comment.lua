local comment = require 'Comment'
local ft = require 'Comment.ft'

comment.setup {
  ignore = '^$',
  toggler = {
    line = '<leader>cl',
    block = '<leader>cb',
  },
  opleader = {
    line = '<leader>cl',
    block = '<leader>cb',
  },
  mappings = {
    basic = true,
    extra = false,
  },
}

ft.set('asm', {'//%s', '/*%s*/'})
