return {
  { 'tpope/vim-rhubarb', lazy = false },
  {
    "ldelossa/gh.nvim",
    lazy = false,
    dependencies = {
      { "ldelossa/litee.nvim", config = function() require("litee.lib").setup() end, },
    },
    config = function() require("litee.gh").setup() end,
  },
}
