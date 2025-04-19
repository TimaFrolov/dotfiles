return {
  { '<leader>gst', vim.cmd.Git,                        desc = '[G]it [ST]atus' },
  { '<leader>gph', ':Git push<cr>',                    desc = '[G]it [P]us[H]',              silent = true },
  { '<leader>gpf', ':Git push --force-with-lease<cr>', desc = '[G]it [P]ush by [F]orce',     silent = true },
  { '<leader>gbl', ':Git blame -w -C -C -C<cr>',       desc = '[G]it [BL]ame',               silent = true },
  { '<leader>grc', ':Git rebase --continue<cr>',       desc = '[G]it [R]ebase [C]ontinue',   silent = true },
  { '<leader>gfh', ':Git fetch<cr>',                   desc = '[G]it [F]etc[H]',             silent = true },
}
