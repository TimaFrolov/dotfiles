vim.keymap.set("n", "<leader>gst", vim.cmd.Git, { desc = "[G]it [ST]atus" })
vim.keymap.set("n", "<leader>glg", ":Git log<cr>", { desc = "[G]it [L]o[G]" })
vim.keymap.set("n", "<leader>gcm", ":Git commit<cr>", { desc = "[G]it [C]o[M]mit" })
vim.keymap.set("n", "<leader>gca", ":Git commit --amend<cr>", { desc = "[G]it [C]ommit --[A]mend" })
vim.keymap.set("n", "<leader>gsw", ":Git switch ", { desc = "[G]it [SW]itch" })
vim.keymap.set("n", "<leader>gph", ":Git push<cr>", { desc = "[G]it [P]us[H]" })
vim.keymap.set("n", "<leader>gpf", ":Git push --force-with-lease<cr>", { desc = "[G]it [P]ush by [F]orce" })
vim.keymap.set("n", "<leader>gpl", ":Git pull<cr>", { desc = "[G]it [P]ul[L]" })
vim.keymap.set("n", "<leader>gsh", ":Git stash<cr>", { desc = "[G]it [S]tas[H]" })
vim.keymap.set("n", "<leader>gsp", ":Git stash pop<cr>", { desc = "[G]it [S]tash [P]op" })
vim.keymap.set("n", "<leader>gbl", ":Git blame<cr>", { desc = "[G]it [BL]ame" })
vim.keymap.set("n", "<leader>grb", ":Git rebase ", { desc = "[G]it [R]e[B]ase" })
vim.keymap.set("n", "<leader>gri", ":Git rebase --interactive", { desc = "[G]it [R]ebase [I]nteractive" })
vim.keymap.set("n", "<leader>grc", ":Git rebase --continue<cr>", { desc = "[G]it [R]ebase [C]ontinue" })
vim.keymap.set("n", "<leader>gmg", ":Git merge ", { desc = "[G]it [M]er[G]e" })
vim.keymap.set("n", "<leader>gfh", ":Git fetch<cr>", { desc = "[G]it [F]etc[H]" })
