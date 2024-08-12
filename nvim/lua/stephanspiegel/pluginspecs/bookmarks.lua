return {
    'crusj/bookmarks.nvim',
    event = "VeryLazy",
    keys = {
        { "<tab><tab>", mode = { "n" }, desc = "Toggle Bookmarks" },
    },
    branch = 'main',
    dependencies = { 'devicons' },
    config = function()
        require("bookmarks").setup()
        require("telescope").load_extension("bookmarks")
    end
}

