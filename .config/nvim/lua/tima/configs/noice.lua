require('noice').setup({
  cmdline = {
    format = {
      filter = { pattern = "^:%S*!", icon = "$", lang = "bash" },
    }
  },
  messages = {
    view_search = false,
  },
  lsp = {
    hover = { enabled = false },
    signature = { enabled = false },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
  },
  views = {
    mini = {
      position = { row = 0 },
    }
  }
})

require('tima.mappings.noice')
