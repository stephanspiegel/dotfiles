local luasnip = require("luasnip")
-- local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
local function_node = luasnip.function_node
local insert_node = luasnip.insert_node
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
-- local absolute_indexer = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

local date_with_day = snippet_node(1,
  fmt('{year}-{month_and_day}-{day_name}',
    {
      year = text_node(os.date("%Y"), { key="year" }),
      -- month = insert_node(2, function() return os.date("%m") end, {key="month"}),
      month_and_day = dynamic_node(2,
        function(_)
          return snippet_node(nil, insert_node(1, os.date("%m-%d")))
        end,
        { key="day_and_month" }
      ),
      day_name = function_node(function(args)
        print('args: '..vim.inspect(args))
        local match_iterator = string.gmatch(args[2], "%d+")
        local month = match_iterator()
        local day = match_iterator()
        return os.date("%a", os.time({year=args[1], month=month, day=day}))
      end,
        {1,2}
      )
    }
  )
)

return {
--   snippet( { trig='journal', dscr='Insert a journal entry', },
--   fmt([[
-- ** {date_with_day}
-- *** Check-in
--     - Work Overall: 0.{overall}
--     - Wellbeing: 0.{wellbeing}
--     - Growth: 0.{growth}
--     - Work Relationships: 0.{relationships}
--     - Impact and Productivity: 0.{impact}
-- *** Accomplishments
--     {accomplishments}
-- *** Challenges
--     {challenges}
-- *** TIL
--     {til}
-- ]],{
--         date_with_day = date_with_day,
--         overall = insert_node(2),
--         wellbeing = insert_node(3),
--         growth = insert_node(4),
--         relationships = insert_node(5),
--         impact = insert_node(6),
--         accomplishments = insert_node(7),
--         challenges = insert_node(8),
--         til = insert_node(9)
--   }))
}
