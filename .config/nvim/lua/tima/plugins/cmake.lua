return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = {
    "CMakeBuild",
    "CMakeRun",
    "CMakeSettings",
    "CMakeDebug",
    "CMakeClean",
    "CMakeGenerate",
  },
  event = "FileWritePre",
  cond = function() return vim.fn.filereadable('CMakeLists.txt') == 1 end,
  config = function() require 'tima.configs.cmake-tools' end,
}
