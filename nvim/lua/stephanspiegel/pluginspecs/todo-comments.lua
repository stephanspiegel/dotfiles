return {
  "folke/todo-comments.nvim",
  cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope" },
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function(_, opts)
      local todo_comments = require("todo-comments")
    todo_comments.setup(opts)
    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
  end
}
