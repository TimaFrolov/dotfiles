return {
  lazy = {
    { "T", function() require('nvim-treesitter.textobjects.repeatable_move').builtin_T() end,                 mode = { "n", "x", "o", } },
    { ";", function() require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move() end,          mode = { "n", "x", "o", } },
    { ",", function() require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite() end, mode = { "n", "x", "o", } },
    { "f", function() require('nvim-treesitter.textobjects.repeatable_move').builtin_f() end,                 mode = { "n", "x", "o", } },
    { "F", function() require('nvim-treesitter.textobjects.repeatable_move').builtin_F() end,                 mode = { "n", "x", "o", } },
    { "t", function() require('nvim-treesitter.textobjects.repeatable_move').builtin_t() end,                 mode = { "n", "x", "o", } },
  },
  incremental_selection = {
    init_selection = "<leader>vk",
    node_incremental = "<leader>vk",
    scope_incremental = false,
    node_decremental = "<leader>vj",
  },
  textobjects = {
    select = {
      ["i="] = { query = "@assignment.inner" },
      ["a="] = { query = "@assignment.outer" },
      ["=h"] = { query = "@assignment.lhs" },
      ["=l"] = { query = "@assignment.rhs" },
      ["ib"] = { query = "@block.inner" },
      ["ab"] = { query = "@block.outer" },
      ["i@"] = { query = "@call.inner" },
      ["a@"] = { query = "@call.outer" },
      ["ic"] = { query = "@class.inner" },
      ["ac"] = { query = "@class.outer" },
      ["i/"] = { query = "@comment.inner" },
      ["a/"] = { query = "@comment.outer" },
      ["ii"] = { query = "@conditional.inner" },
      ["ai"] = { query = "@conditional.outer" },
      ["if"] = { query = "@function.inner" },
      ["af"] = { query = "@function.outer" },
      ["il"] = { query = "@loop.inner" },
      ["al"] = { query = "@loop.outer" },
      ["in"] = { query = "@number.inner" },
      ["ia"] = { query = "@parameter.inner" },
      ["aa"] = { query = "@parameter.outer" },
      ["ie"] = { query = "@regex.inner" },
      ["ae"] = { query = "@regex.outer" },
      ["ir"] = { query = "@return.inner" },
      ["ar"] = { query = "@return.outer" },
      ["is"] = { query = "@scope.inner" },
      ["as"] = { query = "@statement.outer" },
    },
    swap_next = {
      ["<leader>mnb"] = "@block.inner",
      ["<leader>mnc"] = "@class.outer",
      ["<leader>mni"] = "@conditional.inner",
      ["<leader>mnf"] = "@function.outer",
      ["<leader>mnn"] = "@number.outer",
      ["<leader>mna"] = "@parameter.inner",
      ["<leader>mne"] = "@regex.inner",
      ["<leader>mnr"] = "@return.inner",
      ["<leader>mns"] = "@statement.outer",
    },
    swap_previous = {
      ["<leader>mpb"] = "@block.inner",
      ["<leader>mpc"] = "@class.outer",
      ["<leader>mpi"] = "@conditional.inner",
      ["<leader>mpf"] = "@function.outer",
      ["<leader>mpa"] = "@parameter.inner",
      ["<leader>mpe"] = "@regex.inner",
      ["<leader>mpr"] = "@return.inner",
      ["<leader>mps"] = "@statement.outer",
    },
    move = {
      next_start = {
        ["]b"] = { query = "block.outer", desc = "Next [B]lock start" },
        ["]@"] = { query = "call.outer", desc = "Next (@)call" },
        ["]c"] = { query = "class.outer", desc = "Next [C]lass start" },
        ["]/"] = { query = "comment.outer", desc = "Next comment(//)" },
        ["]i"] = { query = "conditional.outer", desc = "Next [I]f start" },
        ["]f"] = { query = "function.outer", desc = "Next [F]unction start" },
        ["]l"] = { query = "loop.outer", desc = "Next [L]oop start" },
        ["]n"] = { query = "number.inner", desc = "Next [N]umber start" },
        ["]a"] = { query = "parameter.inner", desc = "Next [P]arameter start" },
        ["]e"] = { query = "regex.inner", desc = "Next r[E]gex start" },
        ["]r"] = { query = "return.outer", desc = "Next [R]eturn start" },
        ["]s"] = { query = "statement.outer", desc = "Next [S]tatement start" },
      },
      next_end = {
        ["]B"] = { query = "block.outer", desc = "Next [B]lock end" },
        ["]C"] = { query = "class.outer", desc = "Next [C]lass end" },
        ["]I"] = { query = "conditional.outer", desc = "Next [I]f end" },
        ["]F"] = { query = "function.outer", desc = "Next [F]unction end" },
        ["]L"] = { query = "loop.outer", desc = "Next [L]oop end" },
        ["]N"] = { query = "number.inner", desc = "Next [N]umber end" },
        ["]A"] = { query = "parameter.inner", desc = "Next [P]arameter end" },
        ["]E"] = { query = "regex.inner", desc = "Next r[E]gex end" },
        ["]R"] = { query = "return.outer", desc = "Next [R]eturn end" },
        ["]S"] = { query = "statement.outer", desc = "Next [S]tatement end" },
      },
      previous_start = {
        ["[b"] = { query = "block.outer", desc = "Previous [B]lock start" },
        ["[@"] = { query = "call.outer", desc = "Previous (@)call" },
        ["[c"] = { query = "class.outer", desc = "Previous [C]lass start" },
        ["[/"] = { query = "comment.outer", desc = "Previous comment(//)" },
        ["[i"] = { query = "conditional.outer", desc = "Previous [I]f start" },
        ["[f"] = { query = "function.outer", desc = "Previous [F]unction start" },
        ["[l"] = { query = "loop.outer", desc = "Previous [L]oop start" },
        ["[n"] = { query = "number.inner", desc = "Previous [N]umber start" },
        ["[a"] = { query = "parameter.inner", desc = "Previous [P]arameter start" },
        ["[e"] = { query = "regex.inner", desc = "Previous r[E]gex start" },
        ["[r"] = { query = "return.outer", desc = "Previous [R]eturn start" },
        ["[s"] = { query = "statement.outer", desc = "Previous [S]tatement start" },
      },
      previous_end = {
        ["[B"] = { query = "block.outer", desc = "Previous [B]lock end" },
        ["[C"] = { query = "class.outer", desc = "Previous [C]lass end" },
        ["[I"] = { query = "conditional.outer", desc = "Previous [I]f end" },
        ["[F"] = { query = "function.outer", desc = "Previous [F]unction end" },
        ["[L"] = { query = "loop.outer", desc = "Previous [L]oop end" },
        ["[N"] = { query = "number.inner", desc = "Previous [N]umber end" },
        ["[A"] = { query = "parameter.inner", desc = "Previous [P]arameter end" },
        ["[E"] = { query = "regex.inner", desc = "Previous r[E]gex end" },
        ["[R"] = { query = "return.outer", desc = "Previous [R]eturn end" },
        ["[S"] = { query = "statement.outer", desc = "Previous [S]tatement end" },
      },
    },
  },
}
