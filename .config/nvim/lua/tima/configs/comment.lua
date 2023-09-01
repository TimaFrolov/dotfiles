local comment = require 'Comment'

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

