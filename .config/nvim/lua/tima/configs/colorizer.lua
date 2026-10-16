require('colorizer').setup({
  filetypes = {
    '*',
    '!lazygit',
  },
  user_default_options = {
    RGB = false,
    RRGGBB = true,
    names = false,
    RRGGBBAA = false,
    AARRGGBB = false,
    rgb_fn = false,
    hsl_fn = false,
    css = false,
    css_fn = false,
    mode = 'virtualtext',
    tailwind = false,
    sass = { enable = false, parsers = { 'css' }, },
    virtualtext = '■',
    virtualtext_inline = true,
    virtualtext_mode = 'foreground',
    always_update = true
  },
  buftypes = {
    '*',
    '!prompt',
    '!popup',
  }
})
