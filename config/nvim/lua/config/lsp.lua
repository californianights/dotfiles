local settings = require("config.settings")

local M = {}

M.servers = {
	gopls = {
		settings = {
			gopls = {
				analyses = {
					shadow = true,
					unusedparams = true,
					unusedwrite = true,
				},
				completeUnimported = true,
				gofumpt = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				staticcheck = true,
				usePlaceholders = true,
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	},
	solidity = {
		cmd = {
			"nomicfoundation-solidity-language-server",
			"--stdio",
		},
		filetypes = { "solidity" },
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern(
				"foundry.toml",
				"hardhat.config.js",
				"hardhat.config.ts",
				".git"
			)(fname)
		end,
		single_file_support = true,
	},
	yamlls = {
		settings = {
			yaml = {
				keyOrdering = false,
				schemaStore = {
					enable = false,
					url = "",
				},
			},
		},
	},
	jsonls = {
		settings = {
			json = {
				validate = { enable = true },
			},
		},
	},
	taplo = {},
	dockerls = {},
	bashls = {},
	marksman = {},
}

function M.setup()
	vim.diagnostic.config({
		severity_sort = true,
		underline = true,
		update_in_insert = false,
		virtual_text = settings.diagnostics_virtual_text,
		float = {
			border = "rounded",
			source = "if_many",
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			map("gd", vim.lsp.buf.definition, "Go to definition")
			map("gD", vim.lsp.buf.declaration, "Go to declaration")
			map("gr", vim.lsp.buf.references, "List references")
			map("gI", vim.lsp.buf.implementation, "Go to implementation")
			map("K", vim.lsp.buf.hover, "Hover documentation")
			map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
			map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
			map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
			map("[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, "Previous diagnostic")
			map("]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, "Next diagnostic")

			if settings.inlay_hints and client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		capabilities = cmp_lsp.default_capabilities(capabilities)
	end

	local schema_ok, schemastore = pcall(require, "schemastore")
	if schema_ok then
		M.servers.jsonls.settings.json.schemas = schemastore.json.schemas()
		M.servers.yamlls.settings.yaml.schemas = schemastore.yaml.schemas()
	end

	for name, opts in pairs(M.servers) do
		opts.capabilities = capabilities
		vim.lsp.config(name, opts)
	end

	vim.lsp.enable(vim.tbl_keys(M.servers))
end

return M

