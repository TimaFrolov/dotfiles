require('noice').setup({
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    format = {
      filter = { pattern = '^:%S*!', icon = '$', lang = 'bash' },
    },
  },
  messages = {
    enabled = true,
    view = 'notify',
    view_error = 'notify',
    view_warn = 'notify',
    view_history = 'messages',
    view_search = false,
  },
  popupmenu = {
    enabled = true,
    backend = 'nui',
  },
  redirect = {
    view = 'popup',
    filter = { event = 'msg_show' },
  },
  notify = {
    enabled = true,
    view = 'notify',
  },
  lsp = {
    progress = { enabled = true, view = 'mini' },
    hover = {
      enabled = true,
      silent = false,
      opts = {
        border = 'rounded',
        position = { row = 1, col = 1 },
      },
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true,
        luasnip = true,
      },
      opts = {
        border = 'rounded',
        position = { row = 1, col = 1 },
      },
    },
    message = { enabled = true, view = 'notify' },
    documentation = { view = 'hover' },
  },
  health = { checker = true },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  views = {
    mini = {
      position = { row = 0 },
    }
  },
})
