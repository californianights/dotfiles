return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = true,
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
        keys = {
            {
                "]h",
                function()
                    require("gitsigns").next_hunk()
                end,
                desc = "Next git hunk",
            },
            {
                "[h",
                function()
                    require("gitsigns").prev_hunk()
                end,
                desc = "Previous git hunk",
            },
            {
                "<leader>gb",
                function()
                    require("gitsigns").blame_line()
                end,
                desc = "Blame line",
            },
            {
                "<leader>gp",
                function()
                    require("gitsigns").preview_hunk()
                end,
                desc = "Preview hunk",
            },
            {
                "<leader>gr",
                function()
                    require("gitsigns").reset_hunk()
                end,
                desc = "Reset hunk",
            },
            {
                "<leader>gs",
                function()
                    require("gitsigns").stage_hunk()
                end,
                desc = "Stage hunk",
            },
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread" },
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
        },
    },
}