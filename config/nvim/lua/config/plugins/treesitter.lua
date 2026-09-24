return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        main = "nvim-treesitter",
        opts = {
                ensure_installed = {
                    "bash",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "regex",
		    "solidity",
                    "sql",
                    "toml",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
        },
    },
}
