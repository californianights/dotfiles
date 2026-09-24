return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "CursorMoved", "WinScrolled" },
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			direction = "horizontal",
			size = 14,
			start_in_insert = true,
			insert_mappings = false,
		},
	},
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"romus204/go-tagger.nvim",
		config = function()
			require("go-tagger").setup({
				skip_private = true, -- Skip unexported fields (starting with lowercase)
				casing = "camelCase", -- Global casing setting
				tags = { -- Per tag setting override
					json = {
						casing = "camelCase", -- json tags should use camelCase
					},
					xml = {
						casing = "snake_case", -- xml tags should use snake_case
					},
				},
			})
		end,
	},
	{
		"Weyaaron/nvim-training",
		cmd = "Training",
		pin = true,
		opts = {},
	},
}
