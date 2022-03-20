local luasnip = require("luasnip")
-- local choice_node = luasnip.choice_node
-- local dynamic_node = luasnip.dynamic_node
-- local function_node = luasnip.function_node
local insert_node = luasnip.insert_node
local snippet = luasnip.snippet
-- local snippet_node = luasnip.snippet_node
-- local text_node = luasnip.text_node
-- local absolute_indexer = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  snippet(
  { trig='debug'
  , dscr='Debug a variable or expression'
  }
  , fmt(
      "print('{}: '..vim.inspect({}))"
      , { insert_node(1)
        , rep(1)
        }
  ))
}
