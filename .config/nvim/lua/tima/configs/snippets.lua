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
  s([[dd]], { t([[\delta]]), }),
  s(
    [[beg ]],
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
  s(
    [[//]],
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
    { trig = [[(%d+)/]], regTrig = true },
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
    [[bar]],
    fmta(
      [[\overline{<>}<>]],
      {
        i(1),
        i(0)
      })
  ),
  s(
    { trig = [[(%a)bar]], regTrig = true },
    fmta(
      [[\overline{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(0)
      }
    )
  ),
  s(
    [[hat]],
    fmta(
      [[\hat{<>}<>]],
      {
        i(1),
        i(0)
      })
  ),
  s(
    { trig = [[(%a)hat]], regTrig = true },
    fmta(
      [[\hat{<>}<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(0)
      }
    )
  ),
  s([[!>]], t([[\mapsto]])),
  s([[->]], t([[\to]])),
  s({ trig = [[<->]], priority = 2000 }, t([[\leftrightarrow]])),
  s([[=>]], t([[\Rightarrow]])),
  s({ trig = [[<=>]], priority = 2000 }, t([[\Leftrightarrow]])),
  s([[cc]], t([[\subset]])),
  s([[\notin]], t([[\not\in]])),
  s([[inn]], t([[\in]])),
  s([[Nn]], t([[\cap]])),
  s([[Uu]], t([[\cup]])),
  s([[uuu]], t([[\bigcup]])),
  s([[nnn]], t([[\bigcap]])),
  s([[OO]], t([[\emptyset]])),
  s([[NN]], t([[\mathbb{N}]])),
  s([[RR]], t([[\mathbb{R}]])),
  s([[QQ]], t([[\mathbb{Q}]])),
  s([[ZZ]], t([[\mathbb{Z}]])),
  s([[CC]], t([[\mathbb{C}]])),
  s([[LL]], t([[\mathbb{L}]])),
  s(
    [[tt]],
    fmta([[\text{<>}<>]], { i(1), i(0) })
  ),
  s(
    [[case ]],
    fmta(
      [[\begin{cases}
<>
\end{cases}<>]],
      { i(1), i(0) }
    )
  ),
  s([[ooo]], t([[\infty]])),
  s(
    [[lim ]],
    fmta([[\lim_{<> \to <>}<>]], { i(1), i(2), i(0) })
  ),
  s([[Ee]], t([[\exists]])),
  s([[Aa]], t([[\forall]])),
  s([[<= ]], t([[\leq ]])),
  s([[<==]], t([[\Leftarrow]])),
  s([[>= ]], t([[\geq ]])),
  s([[+-]], t([[\pm]])),
  s([[\-]], t([[\setminus]])),
  s([[<)]], t([[\sphericalangle]])),
  s(
    [[~~]],
    fmta([[\tilde{<>}<>]], { i(1), i(0) })
  ),
  s([[ee]], t([[\epsilon]])),
  s([[aa]], t([[\alpha]])),
  s([[bb]], t([[\beta]])),
  s([[dd]], t([[\delta]])),
  s([[gg]], t([[\gamma]])),
  s([[ll]], t([[\lambda]])),
  s([[ss]], t([[\sigma]])),
  s({ trig = [[\dd]], priority = 2000 }, t([[\dd]])),
  s([[\da]], t([[\downarrow]])),
  s([[\ua]], t([[\uparrow]])),
  s([[\~]], t([[\backsim]])),
  s([[\qsrt]], t([[\sqrt]])),
  s([[\uns]], t([[\underset]])),
  s(
    { trig = [[([bvp]?)matrix]], regTrig = true },
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
  s([[<|]], t([[\triangleleft]])),
  s([[<=|]], t([[\trianglelefteq]])),
  s([[~=]], t([[\simeq]])),
  s([[PP]], t([[\mathcal{P}]])),
  s([[uuU]], t([[\bigsqcup]])),
  s([[uU]], t([[\sqcup]])),
  s([[AA]], t([[\mathfrak{A}]])),
  s([[Dd]], t([[\Delta]])),
  s([[Dd]], t([[\Delta]])),
  s([[nN]], t([[\mathcal{N}]])),
  s([[Ll]], t([[\Lambda]])),
  s([[<>]], t([[\lessgtr]])),
  s([[\to->]], t([[\rightrightarrows]])),
  s([[GG]], t([[\Gamma]])),
  s([[FF]], t([[\mathbb{F}]])),
  s([[|-]], t([[\vdash]])),
  s([[ww]], t([[\omega]])),
  s([[dp]], t([[\partial]])),
  s([[\int\int]], t([[\iint]])),
}, { type = "autosnippets", key = "all_auto" })
