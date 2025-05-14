local function telescope()
  return require('telescope.builtin')
end

local swap_inlay_hints = (function()
  local hints = false

  local autocmd = function()
    vim.lsp.inlay_hint.enable(hints, { bufnr = nil })
  end

  vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, { callback = autocmd })

  return function()
    hints = not hints
    for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
      vim.lsp.inlay_hint.enable(hints, { bufnr = bufnr })
    end
  end
end)()

local function open_float()
  vim.diagnostic.open_float({ border = 'rounded' })
end

-- local function diagnostic_jump(opts)
--   vim.diagnostic.jump(opts)
--   vim.schedule(function() open_float() end)
-- end

return {
  { mode = 'n', '<leader>fR', ':LspRestart<cr>',                                                    desc = '[R]estart LSP client',     silent = true },
  { mode = 'n', '<leader>fI', ':LspInfo<cr>',                                                       desc = 'Show LSP client [I]nfo',   silent = true },
  { mode = 'n', '<leader>fL', ':LspLog<cr>',                                                        desc = 'Show LSP client [L]og',    silent = true },
  { mode = 'n', '<leader>fh', swap_inlay_hints,                                                     desc = 'Toggle inlay [H]ints' },
  { mode = 'n', '<leader>fr', vim.lsp.buf.rename,                                                   desc = '[R]ename lsp symbol' },
  { mode = 'n', '<leader>fa', vim.lsp.buf.code_action,                                              desc = 'Show code [A]ctions' },
  { mode = 'v', '<leader>fa', vim.lsp.buf.code_action,                                              desc = 'Show code [A]ctions' },
  { mode = 'n', '<leader>fs', ':ClangdSwitchSourceHeader<cr>',                                      desc = '[S]witch source/header',   silent = true, ft = { 'cpp', 'c' } },
  { mode = 'n', '<leader>fc', vim.lsp.codelens.refresh,                                             desc = 'Refresh LSP [C]odelens' },
  { mode = 'n', 'gr',         function() telescope().lsp_references() end,                          desc = '[G]o to [R]eferences' },
  { mode = 'n', 'gd',         function() telescope().lsp_definitions() end,                         desc = '[G]o to [D]efinitions' },
  { mode = 'n', 'go',         function() telescope().lsp_type_definitions() end,                    desc = '[GO] to type definitions' },
  { mode = 'n', 'gi',         function() telescope().lsp_implementations() end,                     desc = '[G]o to [I]mplementations' },
  { mode = 'n', 'gl',         function() open_float() end,                                          desc = 'Open diagnostics' },
  -- { mode = 'n', ']d',         function() diagnostic_jump({ count = 1 }) end,                        desc = 'Open diagnostics' },
  -- { mode = 'n', '[d',         function() diagnostic_jump({ count = -1 }) end,                       desc = 'Open diagnostics' },
  -- { mode = 'n', ']D',         function() diagnostic_jump({ count = math.huge, wrap = false }) end,  desc = 'Open diagnostics' },
  -- { mode = 'n', '[D',         function() diagnostic_jump({ count = -math.huge, wrap = false }) end, desc = 'Open diagnostics' },
}
