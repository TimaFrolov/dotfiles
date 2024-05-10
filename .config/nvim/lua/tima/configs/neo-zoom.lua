local neo_zoom = require('neo-zoom')

neo_zoom.setup {
  popup = { enabled = false },
  winopts = {
    offset = {
      width = 0.95,
      height = 0.95,
    },
    border = 'none',
  },
}
