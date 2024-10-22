vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.sidescrolloff = 16

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

vim.opt.showmode = false
vim.opt.conceallevel = 2

vim.opt.langmap = {
  'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  'фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
}

vim.opt.mouse = ''

vim.opt.listchars = {
  tab = '  ',
  lead = '·',
  trail = '·',
  extends = '❯',
  precedes = '❮',
  nbsp = '␣',
}

vim.opt.spelllang = 'en,ru'
vim.opt.spell = true

vim.opt.path:append("**")
