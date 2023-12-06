-- TODO: Use lua api instead of ':<Command>' where possible

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>n", vim.cmd.Ex, { desc = "Open Ex" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "help J" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "help CTRL-d" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "help CTRL-u" })
vim.keymap.set("n", "n", "nzzzv", { desc = "help n" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "help N" })
vim.keymap.set("i", "<C-E>", "<Esc>")

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("n", "<leader>,", "<C-w>10000<<C-w>40>", { desc = "Make window smaller (horizontally)" })
vim.keymap.set("n", "<leader>-", "<C-w>10000-<C-w>15+", { desc = "Make window smaller (vertically)" })

vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Change word under cursor" })

vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", { desc = "[T]ab [N]ext" })
vim.keymap.set("n", "<leader>tp", ":tabprev<cr>", { desc = "[T]ab [P]revious" })
vim.keymap.set("n", "<leader>to", ":tabnew<cr>", { desc = "[T]ab [O]pen new" })
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>", { desc = "[T]ab close(X)" })
vim.keymap.set("n", "<leader>tm", ":term<cr>", { desc = "Open [T]er[M]inal" })
vim.keymap.set("n", "<esc>", ":noh<cr>")

vim.keymap.set("t", "<C-p>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Exit terminal insert mode" })

local listSwap = (function()
  local list = false

  local swap = function()
    list = not list
    for _, window in pairs(vim.api.nvim_list_wins()) do
      vim.wo[window][0].list = list
    end
  end

  local autocmd = function()
    vim.opt.list = list
  end

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, { callback = autocmd })

  return swap
end)()

vim.keymap.set("n", "<leader>fl", listSwap, { desc = "[F]ile toggle [L]ist" })

local wrapSwap = function()
  local window = vim.api.nvim_get_current_win()
  vim.wo[window][0].wrap = not vim.wo[window][0].wrap
end
vim.keymap.set("n", "<leader>fw", wrapSwap, { desc = "[F]ile toggle [W]rap" })

require('which-key').register {
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]ab/[T]erm', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ap', _ = 'which_key_ignore' },
  ['<leader>c'] = { name = '[C]omment', _ = 'which_key_ignore' },
  ['<leader>v'] = { name = '[V]isual selection', _ = 'which_key_ignore' },
  ['<leader>m'] = { name = '[M]ove', _ = 'which_key_ignore' },
  ['<leader>mn'] = { name = '[M]ove to [Next]', _ = 'which_key_ignore' },
  ['<leader>mp'] = { name = '[M]ove to [Previous]', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
  ['<leader>de'] = { name = '[D]ile [E]xceptions', _ = 'which_key_ignore' },
  ['<leader>ds'] = { name = '[D]ile [S]tep', _ = 'which_key_ignore' },
  ['<leader>ga'] = { name = '[G]it [A]dd', _ = 'which_key_ignore' },
  ['<leader>gb'] = { name = '[G]it [B]lame', _ = 'which_key_ignore' },
  ['<leader>gc'] = { name = '[G]it [C]ommit', _ = 'which_key_ignore' },
  ['<leader>gd'] = { name = '[G]it [D]iff', _ = 'which_key_ignore' },
  ['<leader>gf'] = { name = '[G]it [F]etch', _ = 'which_key_ignore' },
  ['<leader>gl'] = { name = '[G]it [L]ine blame', _ = 'which_key_ignore' },
  ['<leader>gm'] = { name = '[G]it [M]erge', _ = 'which_key_ignore' },
  ['<leader>gp'] = { name = '[G]it [P]ush/[P]ull', _ = 'which_key_ignore' },
  ['<leader>gr'] = { name = '[G]it [R]eset/[R]ebase', _ = 'which_key_ignore' },
  ['<leader>gs'] = { name = '[G]it [S]tash/[S]tatus/[S]witch', _ = 'which_key_ignore' },
}
