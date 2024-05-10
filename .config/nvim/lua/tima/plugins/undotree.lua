return {
  "mbbill/undotree",
  keys = require 'tima.mappings.undotree',
  event = { "BufReadPre", "BufNewFile" },
  config = function() require 'tima.configs.undotree' end,
}
