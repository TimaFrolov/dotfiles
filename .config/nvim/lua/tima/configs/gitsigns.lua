local gitsigns = require 'gitsigns'

gitsigns.setup {
   current_line_blame_opts = {
    delay = 10,
  },
  numhl = true,
  update_debounce=10,
}

require 'tima.mappings.gitsings'
