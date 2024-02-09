local lualine = require('lualine')

lualine.setup {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { {
      require("noice").api.status.mode.get,
      cond = require("noice").api.status.mode.has,
    },
      'searchcount', 'encoding', 'fileformat', 'filetype' },
    lualine_y = {},
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'location' },
    lualine_z = {},
  },
}
