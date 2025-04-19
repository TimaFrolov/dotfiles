local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

luasnip.config.setup({
  enable_autosnippets = true,
})

local math_nodes = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local text_nodes = {
  text_mode = true,
  label_definition = true,
  label_reference = true,
}

local function is_math_mode(_, _, _)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2]
  local node = vim.treesitter.get_parser(0, "latex")
      :parse({ row, col, row, col })[1]
      :root()
      :named_descendant_for_range(row, col, row, col)
  while node ~= nil do
    vim.fn.printf(node:type())
    if math_nodes[node:type()] then
      return true
    elseif text_nodes[node:type()] then
      return false
    else
      node = node:parent()
    end
  end
  return false
end

luasnip.add_snippets("lua", {
  s("snip",
    fmta([[s("<>",
    fmta(<>,
      {
        <>
      }
    )
  ),
<>]],
      {
        i(1),
        i(2),
        i(3),
        i(0)
      }
    )
  ),
})

luasnip.add_snippets("tex", {
  s(
    [[beg]],
    fmta(
      [[\begin{<>}
<>
\end{<>}]],
      {
        i(1),
        i(0),
        rep(1),
      }
    )
  ),
  s([[m]], fmta([[$<>$<>]], {i(1), i(0)})),
})

luasnip.add_snippets("tex", {
  s({ trig = [[biglor]], show_condition = is_math_mode }, fmta([[\bigvee_{<>}<>]], {i(1), i(0)})),
  s({ trig = [[bigand]], show_condition = is_math_mode }, fmta([[\bigwedge_{<>}<>]], {i(1), i(0)})),
  s({ trig = [[\{]], show_condition = is_math_mode }, fmta([[\{<>\}<>]], {i(1), i(0)})),
})

luasnip.add_snippets("tex", {
  s({ trig = [[dd]], condition = is_math_mode }, { t([[\delta]]), }),
  s(
    { trig = [[//]], condition = is_math_mode },
    fmta(
      [[\frac{<>}{<>}<>]],
      {
        i(1),
        i(2),
        i(0)
      }
    )
  ),
  s(
    { trig = [[(\?%w[%w_]*)/]], condition = is_math_mode, regTrig = true },
    fmta(
      [[\frac{<>}{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(0)
      }
    )
  ),
  s(
    { trig = [[bar]], condition = is_math_mode },
    fmta(
      [[\overline{<>}<>]],
      {
        i(1),
        i(0)
      })
  ),
  s(
    { trig = [[(%a)bar]], condition = is_math_mode, regTrig = true },
    fmta(
      [[\overline{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(0)
      }
    )
  ),
  s(
    { trig = [[hat]], condition = is_math_mode },
    fmta(
      [[\hat{<>}<>]],
      {
        i(1),
        i(0)
      })
  ),
  s(
    { trig = [[(%a)hat]], condition = is_math_mode, regTrig = true },
    fmta(
      [[\hat{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(0)
      }
    )
  ),
  s({ trig = [[!>]], condition = is_math_mode }, t([[\mapsto]])),
  s({ trig = [[->]], condition = is_math_mode }, t([[\to]])),
  s({ trig = [[<->]], condition = is_math_mode, priority = 2000 }, t([[\leftrightarrow]])),
  s({ trig = [[=>]], condition = is_math_mode }, t([[\Rightarrow]])),
  s({ trig = [[<=>]], condition = is_math_mode, priority = 2000 }, t([[\Leftrightarrow]])),
  s({ trig = [[cc]], condition = is_math_mode }, t([[\subset]])),
  s({ trig = [[\notin]], condition = is_math_mode }, t([[\not\in]])),
  s({ trig = [[inn]], condition = is_math_mode }, t([[\in]])),
  s({ trig = [[Nn]], condition = is_math_mode }, t([[\cap]])),
  s({ trig = [[Uu]], condition = is_math_mode }, t([[\cup]])),
  s({ trig = [[uuu]], condition = is_math_mode }, t([[\bigcup]])),
  s({ trig = [[nnn]], condition = is_math_mode }, t([[\bigcap]])),
  s({ trig = [[OO]], condition = is_math_mode }, t([[\emptyset]])),
  s({ trig = [[NN]], condition = is_math_mode }, t([[\mathbb{N}]])),
  s({ trig = [[RR]], condition = is_math_mode }, t([[\mathbb{R}]])),
  s({ trig = [[QQ]], condition = is_math_mode }, t([[\mathbb{Q}]])),
  s({ trig = [[ZZ]], condition = is_math_mode }, t([[\mathbb{Z}]])),
  s({ trig = [[CC]], condition = is_math_mode }, t([[\mathbb{C}]])),
  s({ trig = [[LL]], condition = is_math_mode }, t([[\mathbb{L}]])),
  s(
    { trig = [[tt]], condition = is_math_mode },
    fmta([[\text{<>}<>]], { i(1), i(0) })
  ),
  s(
    { trig = [[case ]], condition = is_math_mode },
    fmta(
      [[\begin{cases}
<>
\end{cases}<>]],
      { i(1), i(0) }
    )
  ),
  s({ trig = [[ooo]], condition = is_math_mode }, t([[\infty]])),
  s({ trig = [[_ooo]], condition = is_math_mode }, t([[_\infty]])),
  s(
    { trig = [[lim ]], condition = is_math_mode },
    fmta([[\lim_{<> \to <>}<>]], { i(1), i(2), i(0) })
  ),
  s({ trig = [[Ee]], condition = is_math_mode }, t([[\exists]])),
  s({ trig = [[Aa]], condition = is_math_mode }, t([[\forall]])),
  s({ trig = [[<= ]], condition = is_math_mode }, t([[\leq ]])),
  s({ trig = [[<==]], condition = is_math_mode }, t([[\Leftarrow]])),
  s({ trig = [[>= ]], condition = is_math_mode }, t([[\geq ]])),
  s({ trig = [[+-]], condition = is_math_mode }, t([[\pm]])),
  s({ trig = [[\-]], condition = is_math_mode }, t([[\setminus]])),
  s({ trig = [[<)]], condition = is_math_mode }, t([[\sphericalangle]])),
  s(
    { trig = [[~~]], condition = is_math_mode },
    fmta([[\tilde{<>}<>]], { i(1), i(0) })
  ),
  s({ trig = [[ee]], condition = is_math_mode }, t([[\epsilon]])),
  s({ trig = [[aa]], condition = is_math_mode }, t([[\alpha]])),
  s({ trig = [[bb]], condition = is_math_mode }, t([[\beta]])),
  s({ trig = [[gg]], condition = is_math_mode }, t([[\gamma]])),
  s({ trig = [[ll]], condition = is_math_mode }, t([[\lambda]])),
  s({ trig = [[ss]], condition = is_math_mode }, t([[\sigma]])),
  s({ trig = [[\dd]], condition = is_math_mode, priority = 2000 }, t([[\dd]])),
  s({ trig = [[\da]], condition = is_math_mode }, t([[\downarrow]])),
  s({ trig = [[\ua]], condition = is_math_mode }, t([[\uparrow]])),
  s({ trig = [[\~]], condition = is_math_mode }, t([[\backsim]])),
  s({ trig = [[\qsrt]], condition = is_math_mode }, t([[\sqrt]])),
  s({ trig = [[\uns]], condition = is_math_mode }, t([[\underset]])),
  s(
    { trig = [[([bvp]?)matrix]], condition = is_math_mode, regTrig = true },
    fmta(
      [[\begin{<>matrix}
  <>
\end{<>matrix}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        f(function(_, snip) return snip.captures[1] end),
        i(0),
      }
    )
  ),
  s({ trig = [[<|]], condition = is_math_mode }, t([[\triangleleft]])),
  s({ trig = [[<=|]], condition = is_math_mode }, t([[\trianglelefteq]])),
  s({ trig = [[~=]], condition = is_math_mode }, t([[\simeq]])),
  s({ trig = [[PP]], condition = is_math_mode }, t([[\mathcal{P}]])),
  s({ trig = [[uuU]], condition = is_math_mode }, t([[\bigsqcup]])),
  s({ trig = [[uU]], condition = is_math_mode }, t([[\sqcup]])),
  s({ trig = [[AA]], condition = is_math_mode }, t([[\mathfrak{A}]])),
  s({ trig = [[Dd]], condition = is_math_mode }, t([[\Delta]])),
  s({ trig = [[Dd]], condition = is_math_mode }, t([[\Delta]])),
  s({ trig = [[nN]], condition = is_math_mode }, t([[\mathcal{N}]])),
  s({ trig = [[Ll]], condition = is_math_mode }, t([[\Lambda]])),
  s({ trig = [[<>]], condition = is_math_mode }, t([[\lessgtr]])),
  s({ trig = [[\to->]], condition = is_math_mode }, t([[\rightrightarrows]])),
  s({ trig = [[GG]], condition = is_math_mode }, t([[\Gamma]])),
  s({ trig = [[FF]], condition = is_math_mode }, t([[\mathbb{F}]])),
  s({ trig = [[|-]], condition = is_math_mode }, t([[\vdash]])),
  s({ trig = [[ww]], condition = is_math_mode }, t([[\omega]])),
  s({ trig = [[dp]], condition = is_math_mode }, t([[\partial]])),
  s({ trig = [[\int\int]], condition = is_math_mode }, t([[\iint]])),
  s({ trig = [[Ff]], condition = is_math_mode }, t([[\mathcal{F}]])),
  s({ trig = [[~>]], condition = is_math_mode }, t([[\leadsto]])),
  s({ trig = [[KK]], condition = is_math_mode }, t([[\mathcal{K}]])),
  s({ trig = [[BB]], condition = is_math_mode }, t([[\Beta]])),
  s({ trig = [[\vdash>]], condition = is_math_mode }, t([[\mapsto]])),
  s(
    { trig = [[(%a)vec]], condition = is_math_mode, regTrig = true },
    fmta(
      [[\vec{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(0)
      }
    )
  ),
  s({ trig = [[-/]], condition = is_math_mode }, t([[\rightharpoondown]])),
  s({ trig = [[>-]], condition = is_math_mode }, t([[\succ]])),
  s({ trig = [[\succ=]], condition = is_math_mode }, t([[\succeq]])),
  s({ trig = [[-<]], condition = is_math_mode }, t([[\prec]])),
  s({ trig = [[\prec=]], condition = is_math_mode }, t([[\preceq]])),
}, { type = "autosnippets", key = "all_auto" })
