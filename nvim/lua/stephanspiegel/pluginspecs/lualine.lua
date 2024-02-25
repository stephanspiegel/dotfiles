-- adapted from feline-nvim/feline.nvim
local api = vim.api
local scroll_bar_blocks = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }

local get_scroll_position = function()
  local current_line = api.nvim_win_get_cursor(0)[1]
  local lines = api.nvim_buf_line_count(0)
  local scroll_ratio = current_line / lines
  return current_line, scroll_ratio
end

local line_percentage = function()
  local current_line, scroll_ratio = get_scroll_position()
    if current_line == 1 then
        return ' ﬢ '
      elseif scroll_ratio == 1 then
        return ' ﬠ '
      else
        return string.format('%2d%%%%', math.ceil(scroll_ratio * 99))
    end
end

local scroll_bar = function()
  local _, scroll_ratio = get_scroll_position()
  return string.rep(scroll_bar_blocks[math.floor(scroll_ratio * 7) + 1], 2)
end
-- end adapted from feline

local progress = function()
  return string.format('%s %s', scroll_bar(), line_percentage())
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "devicons", config = true },
  event = "VeryLazy",
  opts = {
    options = {
      component_separators = {
        left = "",
        right = ""
      },
      disabled_filetypes = {'vista_kind'},
      section_separators = {
        left = "",
        right = ""
      },
      theme = "auto"
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {

          "diagnostics",
          sources = {  'nvim_lsp', 'nvim_diagnostic' }
        },
        "searchcount"
      },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { function() return progress() end },
      lualine_z = { "location" }
    },
    tabline = {
      lualine_a = { function() return string.upper(require'stephanspiegel.title'.project_name()) end },
      lualine_b = {'branch', 'diff'},
      lualine_c = {'buffers'},
      lualine_x = { {'filename', path = 1} },
      lualine_y = {},
      lualine_z = {'tabs'}
    },
    extensions = {'fugitive', 'nvim-tree', 'quickfix'}
  }
}
