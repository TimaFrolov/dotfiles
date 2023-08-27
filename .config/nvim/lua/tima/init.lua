-- Set options
require("tima.options")

-- Run plugins
require("tima.lazy")

-- Set theme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Set mappings
require("tima.mappings")

-- Enable local options
vim.o.exrc = true
