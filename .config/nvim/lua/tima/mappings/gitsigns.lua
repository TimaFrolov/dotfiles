return {
  { "<leader>gah", ":Gitsigns stage_hunk<cr>",                mode = "n", desc = "[G]it [A]add [H]unks",        silent = true },
  { "<leader>gah", ":Gitsigns stage_hunk<cr>",                mode = "v", desc = "[G]it [A]add [H]unks",        silent = true },
  { "<leader>gaf", ":Gitsigns stage_buffer<cr>",              mode = "n", desc = "[G]it [A]add [F]ile",         silent = true },
  { "<leader>gi",  ":Gitsigns preview_hunk_inline<cr>",       mode = "n", desc = "[G]it preview hunk [I]nline", silent = true },
  { "<leader>gi",  ":Gitsigns preview_hunk_inline<cr>",       mode = "v", desc = "[G]it preview hunk [I]nline", silent = true },
  { "<leader>gdf", ":Gitsigns diffthis<cr>",                  mode = "n", desc = "[G]it [D]if[F]",              silent = true },
  { "[h",          ":Gitsigns prev_hunk<cr>",                 mode = "n", desc = "Previous [H]unk",             silent = true },
  { "]h",          ":Gitsigns next_hunk<cr>",                 mode = "n", desc = "Next [H]unk",                 silent = true },
  { "<leader>grh", ":Gitsigns reset_hunk<cr>",                mode = "n", desc = "[G]it [R]eset [H]unk",        silent = true },
  { "<leader>grh", ":Gitsigns reset_hunk<cr>",                mode = "v", desc = "[G]it [R]eset [H]unk",        silent = true },
  { "<leader>grf", ":Gitsigns reset_buffer<cr>",              mode = "n", desc = "[G]it [R]eset [F]ile",        silent = true },
  { "<leader>glb", ":Gitsigns toggle_current_line_blame<cr>", mode = "n", desc = "[G]it toggle [L]ine [B]lame", silent = true },
}
