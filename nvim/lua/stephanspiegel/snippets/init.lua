local luasnip = require("luasnip")
local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
local function_node = luasnip.function_node
local insert_node = luasnip.insert_node
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
local fmt = require("luasnip.extras.fmt").fmt

local date = function(date_format)
  date_format = date_format or "%Y-%m-%d"
  local date = os.date(date_format)
  return date
end

local git_user_name = function()
  return vim.trim(vim.fn.system("git config --get user.name"))
end

local git_user_email = function()
  return vim.trim(vim.fn.system("git config --get user.email"))
end

local date_input = function(_, _, date_format)
  date_format = date_format or "%Y-%m-%d"
  return snippet_node(nil, insert_node(1, os.date(date_format)))
end

local function is_empty(ln)
  return #ln == 0
end

local comment_string = function()
  local lcs, rcs = vim.bo.commentstring:match("(.*)%%s(.*)")
  return not is_empty(lcs) and vim.trim(lcs), not is_empty(rcs) and vim.trim(rcs)
end

local start_comment_string = function()
  local lcs, _ = comment_string()
  return lcs or ""
end

local end_comment_string = function()
  local _, rcs = comment_string()
  return rcs or ""
end

local signature_node = function(jump_location)
  jump_location = jump_location or 1
  return choice_node(jump_location, {
    text_node("<" .. git_user_email() .. "> " .. git_user_name()),
    text_node(git_user_name()),
    insert_node(nil, git_user_email()),
  })
end

luasnip.add_snippets("all", {
  snippet({
    trig = "todo",
    dscr = "TODO comment",
  }, {
    function_node(start_comment_string),
    text_node("todo " .. date() .. " "),
    signature_node(1),
    text_node(" -- "),
    insert_node(0, "what needs doing"),
    function_node(end_comment_string),
  }),
  snippet({ trig = "signature", dscr = "Identifies who I am" }, { signature_node() }),
})
luasnip.add_snippets("apexcode", require("stephanspiegel.snippets.apex"))
luasnip.add_snippets("lua", require("stephanspiegel.snippets.lua"))
luasnip.add_snippets("beancount", require("stephanspiegel.snippets.beancount"))
luasnip.add_snippets("norg", require("stephanspiegel.snippets.norg"))
