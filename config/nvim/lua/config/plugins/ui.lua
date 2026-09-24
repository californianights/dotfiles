local settings = require("config.settings")

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = settings.theme_style,
            transparent = settings.transparent,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            pcall(vim.cmd.colorscheme, settings.colorscheme)
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local which_key = require("which-key")

            which_key.setup({})
            which_key.add({
                { "<leader>b", group = "Buffers" },
                { "<leader>c", group = "Code" },
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" },
            { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus explorer" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            disable_netrw = true,
            hijack_netrw = true,
            git = {
                enable = true,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            view = {
                side = "left",
                width = settings.explorer_width,
                preserve_window_proportions = true,
            },
            filters = {
                dotfiles = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                },
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                always_show_bufferline = true,
                diagnostics = "nvim_lsp",
                mode = "buffers",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
                separator_style = "slant",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                globalstatus = true,
                icons_enabled = true,
                section_separators = "",
                component_separators = "|",
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
}