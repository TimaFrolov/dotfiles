require("colorizer").setup {
  filetypes = { "*" },
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
    mode = "virtualtext",
    tailwind = false,
    sass = { enable = false, parsers = { "css" }, },
    virtualtext = "■",
    always_update = true
  },
  buftypes = {
    "*",
    "!prompt",
    "!popup",
  }
}
