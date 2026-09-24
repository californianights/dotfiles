local function current_copilot_model(adapter)
	local model = adapter.schema.model.default

	if type(model) == "function" then
		model = model(adapter)
	end

	return tostring(model or ""):lower()
end

local function is_copilot_fixed_sampling_model(adapter)
	local model = current_copilot_model(adapter)

	return vim.startswith(model, "o1") or model:find("codex", 1, true) ~= nil or model:match("^gpt%-?5") ~= nil
end

return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	opts = {
	-- 		panel = {
	-- 			enabled = false,
	-- 		},
	-- 		suggestion = {
	-- 			auto_trigger = true,
	-- 			keymap = {
	-- 				accept = "<C-y>",
	-- 			},
	-- 		},
	-- 	},
	-- },
	--[[	{
		"olimorris/codecompanion.nvim",
		cmd = {
			"CodeCompanion",
			"CodeCompanionActions",
			"CodeCompanionChat",
			"CodeCompanionCLI",
			"CodeCompanionCmd",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"zbirenbaum/copilot.lua",
		},
		opts = {
			adapters = {
				acp = {
					gemini_cli = function()
						return require("codecompanion.adapters").extend("gemini_cli", {
							defaults = {
								auth_method = "gemini-api-key",
								timeout = 20000,
							},
							env = {
								GEMINI_API_KEY = "GEMINI_API_KEY",
							},
						})
					end,
				},
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								temperature = {
									enabled = function(self)
										return not is_copilot_fixed_sampling_model(self)
									end,
								},
								top_p = {
									enabled = function(self)
										return not is_copilot_fixed_sampling_model(self)
									end,
								},
								n = {
									enabled = function(self)
										return not is_copilot_fixed_sampling_model(self)
									end,
								},
							},
						})
					end,
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = {
								api_key = "GEMINI_API_KEY",
							},
							schema = {
								model = {
									default = "gemini-3.6-flash",
								},
							},
						})
					end,
				},
			},
			interactions = {
				chat = {
					adapter = "gemini_cli",
					opts = {
						completion_provider = "cmp",
					},
					slash_commands = {
						["file"] = {
							opts = {
								provider = "telescope",
							},
						},
					},
				},
				inline = {
					adapter = "gemini",
				},
				cmd = {
					adapter = "gemini",
				},
			},
			display = {
				action_palette = {
					provider = "telescope",
				},
			},
		},
	},]]
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
		cmd = { "RenderMarkdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
