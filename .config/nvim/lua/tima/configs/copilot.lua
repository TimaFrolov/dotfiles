require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    tex = false,
  }
})
require('copilot_cmp').setup()
