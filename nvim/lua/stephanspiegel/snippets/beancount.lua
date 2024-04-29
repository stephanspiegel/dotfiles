local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local date = function()
  local date = os.date("%Y-%m-")
  return date
end

return {
  snippet(
    { trig="trans", dscr="Enter a beancount transaction" },
    fmt( [[
{date_frag}{when} ! "{payee}" "{comment}"
  {account1}                                          {amount} {currency}
  {account2}
      ]],
      {
        --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- combine date_frag and `when` into one; default day to day of previous transaction
        date_frag = text_node(date()),
        when = insert_node(1),
        payee = insert_node(2), --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- autocomplete?
        comment = insert_node(3),
        account1 = insert_node(4), --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- autocomplete?
        amount = insert_node(5),
        currency = insert_node(6, "USD"),
        account2 = insert_node(7), --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- autocomplete?
        --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- find a way to `AlignCommodity` when exiting snippet
      }
    )
  ),
  snippet(
    { trig="bal", dscr="Enter a balance assertion" },
    fmt([[
{date_frag}{when} balance {account} {amount} {currency}
    ]],
      {
        --todo 2024-04-28 <stephan@stephanspiegel.com> Stephan Spiegel -- Reuse date_frag + when from above
        date_frag = text_node(date()),
        when = insert_node(1),
        account = insert_node(2),
        amount = insert_node(3),
        currency = insert_node(4, "USD")
      })
  )

}
