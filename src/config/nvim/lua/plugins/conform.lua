require("conform").setup({
	formatters = {
		["clang-format"] = {
			prepend_args = { "--style=Google" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		h = { "clang-format" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		less = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		vue = { "prettierd" },
	},
	format_on_save = {
		lsp_format = "never",
	},
})
