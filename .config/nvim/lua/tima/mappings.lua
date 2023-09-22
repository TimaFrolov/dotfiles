-- TODO: Use lua api instead of ':<Command>' where possible

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>n", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("n", "<leader>,", "<C-w>10000<<C-w>40>")
vim.keymap.set("n", "<leader>-", "<C-w>10000-<C-w>15+")

vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader>tn", ":tabnext<cr>")
vim.keymap.set("n", "<leader>tp", ":tabprev<cr>")
vim.keymap.set("n", "<leader>to", ":tabnew<cr>")
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>")
vim.keymap.set("n", "<leader>tm", ":term<cr>")
vim.keymap.set("n", "<esc>", ":noh<cr>")

vim.keymap.set("t", "<C-p>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
