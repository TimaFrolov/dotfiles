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

vim.keymap.set("n", "<leader>ff", function()
  vim.lsp.buf.format()
end)

vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<C-t>", ":tabnext<cr>")
vim.keymap.set("n", "<esc>", ":noh<cr>")

vim.keymap.set("t", "<C-p>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

-- Plugins
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", telescope.find_files)
vim.keymap.set("n", "<leader>sg", telescope.live_grep)
vim.keymap.set("n", "<leader>sb", telescope.buffers)
vim.keymap.set("n", "<leader>sd", telescope.lsp_document_symbols)
vim.keymap.set("n", "<leader>sp", telescope.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>se", telescope.diagnostics)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>gst", vim.cmd.Git)
vim.keymap.set("n", "<leader>glg", ":Git log<cr>")
vim.keymap.set("n", "<leader>gcm", ":Git commit<cr>")
vim.keymap.set("n", "<leader>gca", ":Git commit --amend<cr>")
vim.keymap.set("n", "<leader>gsw", ":Git switch ")
vim.keymap.set("n", "<leader>gph", ":Git push<cr>")
vim.keymap.set("n", "<leader>gpl", ":Git pull<cr>")
vim.keymap.set("n", "<leader>gsh", ":Git stash<cr>")
vim.keymap.set("n", "<leader>gsp", ":Git stash pop<cr>")
vim.keymap.set("n", "<leader>gbl", ":Git blame<cr>")
vim.keymap.set("n", "<leader>grb", ":Git rebase ")
vim.keymap.set("n", "<leader>gmg", ":Git merge ")
vim.keymap.set("n", "<leader>gfh", ":Git fetch<cr>")

vim.keymap.set("n", "<leader>gah", ":Gitsigns stage_hunk<cr>")
vim.keymap.set("v", "<leader>gah", ":Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<leader>gaf", ":Gitsigns stage_buffer<cr>")
vim.keymap.set("n", "<leader>gi", ":Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("v", "<leader>gi", ":Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "<leader>gdf", ":Gitsigns diffthis<cr>")
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<cr>")
vim.keymap.set("n", "<leader>grh", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("v", "<leader>grh", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>grf", ":Gitsigns reset_buffer<cr>")
vim.keymap.set("n", "<leader>glb", ":Gitsigns toggle_current_line_blame<cr>")

-- Lsp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lsp = require 'lsp-zero'

local luasnip = require('luasnip')
local cmp = require 'cmp'

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      -- they way you will only jump inside the snippet region
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

cmp.setup({
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
  },
  mapping = cmp_mappings,
})
