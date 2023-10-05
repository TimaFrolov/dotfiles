local mappings = require 'tima.mappings.treesitter'

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  sync_install = true,
  auto_install = true,

  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = mappings.incremental_selection
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = mappings.textobjects.select,
    },
    swap = {
      enable = true,
      swap_next = mappings.textobjects.swap_next,
      swap_previous = mappings.textobjects.swap_previous,
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = mappings.textobjects.move.next_start,
      goto_next_end = mappings.textobjects.move.next_end,
      goto_previous_start = mappings.textobjects.move.previous_start,
      goto_previous_end = mappings.textobjects.move.previous_end,
    }
  },
}
