vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up', silent = true })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'help J' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'help CTRL-d' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'help CTRL-u' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'help n' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'help N' })

vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

vim.keymap.set('n', '<leader>tn', ':tabnext<cr>', { desc = '[T]ab [N]ext', silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprev<cr>', { desc = '[T]ab [P]revious', silent = true })
vim.keymap.set('n', '<leader>to', ':tabnew<cr>', { desc = '[T]ab [O]pen new', silent = true })
vim.keymap.set('n', '<leader>tx', ':tabclose<cr>', { desc = '[T]ab close(X)', silent = true })

vim.keymap.set('n', '<leader>tm', ':term<cr>', { desc = 'Open [T]er[M]inal', silent = true })

vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>', { silent = true })

vim.keymap.set('t', '<C-p>', '<C-\\><C-n>', { desc = 'Exit terminal insert mode' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Exit terminal insert mode, then <C-w>' })

local listSwap = (function()
  local list = false

  local autocmd = function()
    vim.opt.list = list
  end

  vim.api.nvim_create_autocmd({ 'BufWinEnter' }, { callback = autocmd })

  return function()
    list = not list
    for _, window in pairs(vim.api.nvim_list_wins()) do
      vim.wo[window][0].list = list
    end
  end
end)()

vim.keymap.set('n', '<leader>fl', listSwap, { desc = '[F]ile toggle [L]ist' })

local wrapSwap = function()
  local window = vim.api.nvim_get_current_win()
  vim.wo[window][0].wrap = not vim.wo[window][0].wrap
end
vim.keymap.set('n', '<leader>fw', wrapSwap, { desc = '[F]ile toggle [W]rap' })

vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('v', 'gra')
vim.keymap.del('n', 'grr')
