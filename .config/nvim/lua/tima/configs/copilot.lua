require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    tex = false,
    toml = false,
  }
})
require('copilot_cmp').setup()
