require('nvim-treesitter').setup({
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
  ignore_install = {},
  sync_install = true,
  auto_install = true,

  highlight = {
    enable = true,
    disable = { 'latex' },
    additional_vim_regex_highlighting = false,
  },
})

require('nvim-treesitter-textobjects').setup({
  select = {
    enable = true,
    lookahead = true,
  },
  swap = {
    enable = true,
  },
  move = {
    enable = true,
    set_jumps = true,
  }
})

vim.api.nvim_create_autocmd("FileType",
  { callback = function() if vim.treesitter.language.add(vim.o.ft) then vim.treesitter.start() end end, })
