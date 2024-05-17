local luasnip = require("luasnip")
local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
local function_node = luasnip.function_node
local insert_node = luasnip.insert_node
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local indent_snippet = luasnip.indent_snippet_node
local text_node = luasnip.text_node
local absolute_indexer = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt

local logging_levels = { "ERROR", "WARN", "INFO", "DEBUG", "FINE", "FINER", "FINEST" }

local lowercase_first_letter = function(text)
  return (text:gsub("^%u", string.lower))
end

local camelCase = function(text)
  local pascalCase = string.gsub(text, "_%a+", function(word)
    local first = string.sub(word, 2, 2)
    local rest = string.sub(word, 3)
    return string.upper(first) .. rest
  end)
  return lowercase_first_letter(pascalCase)
end

local object_to_variable_name = function(object_name)
  local name_space = "ZIPARI__"
  local variable_name = string.gsub(object_name, "__c$", "")
  variable_name = string.gsub(variable_name, name_space, "")
  local camelCasedVariable, _ = camelCase(variable_name)
  return camelCasedVariable
end

local apex_doc_parameter = function(jump_position)
  return snippet_node(
    jump_position,
    fmt(
      "* @param {} ({}): {}",
    { insert_node(1, "parameterName"), insert_node(2, "String"), insert_node(3, "What this parameter means") }
    )
  )
end

local test_spec_snippet = function(jump_position)
  return indent_snippet(
    jump_position,
    fmt(
      [[
    TestSpec spec = new TestSpec()
        .unitUnderTest('{}')
        .given('{}')
        .itShould('{}')
        .expected({})
        .actual({});
      ]],
      {
        insert_node(1),
        insert_node(2),
        insert_node(3),
        insert_node(4),
        insert_node(5),
      },
      { dedent = true }
      ),
      "$PARENT_INDENT"
  )
end

local same_as = function(index)
  return function_node(function(args)
    return args[1]
  end, { index })
end

local inline_soql = function(jump_position, sobject)
  sobject = sobject or "Account"
  return snippet_node(
    jump_position,
    fmt("[ SELECT {} FROM {} ]", {
      insert_node(1, "Id"),
      insert_node(2, sobject),
    })
  )
end

return {
  snippet(
    {
      trig = "debug",
      dscr = "Debug a variable or expression",
    },
    fmt(
      "System.debug(System.LoggingLevel.{}, {});",
      {
        choice_node(2, vim.tbl_map(text_node, logging_levels)),
        choice_node(
          1,
          {
            fmt("'{}: ' + {}", {
              insert_node(1, "<variable to log>"),
              same_as(1),
            }),
            insert_node(nil, "<variable to log>"),
          }
        ),
      }
    )
  ),
  snippet(
    {
      trig = "map",
      dscr = "New Map declaration",
    },
    fmt(
      "Map<{}, {}> {} = new Map<{}>{};",
      {
        insert_node(1, "String"),
        insert_node(2, "Object"),
        insert_node(3, "mapName"),
        function_node(function(args)
          return args[1][1] .. ", " .. args[2][1]
        end, { 1, 2 }),
        choice_node(
          4,
        {
            text_node("()"),
            fmt(
              [[
              {{
                  {}
              }}
              ]],
            { insert_node(1) }
            ),
            fmt("({})", {
              dynamic_node(1, function(args)
                return inline_soql(1, args[1][1])
              end, { absolute_indexer[2] }),
            }),
          }
        ),
      }
    )
  ),
  snippet(
    {
      trig = "list",
      dscr = "New List declaration",
    },
    fmt('List<{}> {} = new List<{}>{};',
      {
        insert_node(1, 'String'),
        dynamic_node(2, function(args)
          return snippet_node(1, insert_node(1, object_to_variable_name(args[1][1]) .. 's'))
        end, { absolute_indexer[1] }),
        same_as(1),
        choice_node(3,
          { text_node('()'),
            fmt( '{{ {} }} ',
              { insert_node(1),
              }
            ),
            fmt('({})',
              {
                dynamic_node(1, function(args)
                  return inline_soql(1, args[1][1])
                end, { absolute_indexer[1] }),
              }
            ),
          }
        ),
      }
    )
  ),
  snippet(
  { trig = "set", dscr = "New Set declaration" },
  {
      text_node("Set<"),
      insert_node(1, "String"),
      text_node("> "),
      insert_node(2, "setName"),
      text_node(" = new Set<"),
      same_as(1),
      text_node(">"),
      choice_node(
        3,
        { text_node("();"),
          { text_node({ " {", "\t" }),
            insert_node(1),
            text_node({ "", "};" })
          },
        }
      ),
    }
  ),
  snippet(
    {
      trig = "test",
      dscr = "Unit test method (optionally with TestSpec)"
    },
    fmt([[
            @isTest
            static void itShould{}(){{
                Test.startTest();
                Test.stopTest();
                {}
            }}
        ]],
      {
        insert_node(1),
        choice_node(
          2,
          {
            text_node("Assert.areEqual(expected, actual);"),
            test_spec_snippet(nil)
          }
        ),
      }
    )
  ),
  snippet(
    { trig = "for", dscr = "`for` loop iterating a collection" },
    {
      text_node("for ("),
      insert_node(1, "String"),
      text_node(" "),
      dynamic_node(2, function(args)
        return snippet_node(1, insert_node(1, object_to_variable_name(args[1][1])))
      end, { absolute_indexer[1] }),
      text_node(" : "),
      choice_node(
        3,
        {
          insert_node(3, "collection"),
          dynamic_node(1, function(args)
            return inline_soql(1, args[1][1])
          end, { absolute_indexer[1] }),
        }
      ),
      text_node({ ") {", "\t" }),
      insert_node(0),
      text_node({ "", "}" }),
    }
  ),
  snippet(
  { trig = "fori", dscr = "traditional `for` loop" },
    fmt(
      [[
        for (Integer i=0; i<{}; i++) {{
            {}
        }}
      ]],
      { insert_node(1), insert_node(0) }
    )
  ),
  snippet(
  { trig = "try", dscr = "try/catch block" },
    fmt(
      [[
        try{{
            {}
        }} catch(Exception ex){{
            {}
        }}
      ]],
      { insert_node(0), insert_node(1) }
    )
  ),
  snippet(
  { trig = "docm", dscr = "Apexdoc method comment" },
    fmt(
      [[
       /**
        * @description {}
        {}
        * @return ({}): {}
        */
      ]],
      {
        insert_node(1, "What this method does"),
        apex_doc_parameter(4),
        insert_node(2, "String"),
        insert_node(3, "What the return value means"),
      }
    )
  ),
  snippet(
  { trig = "doc", dscr = "Apexdoc comment for class or member variable" },
    fmt(
      [[
       /**
        * @description {}
        */
      ]],
      { insert_node(1, "What this class/variable does") }
    )
  ),
  snippet({ trig = "param", dscr = "Apexdoc comment for a parameter" }, apex_doc_parameter(1)),
  snippet({ trig = "testspec", dscr = "TestSpec skeleton" }, test_spec_snippet(1)),
}
