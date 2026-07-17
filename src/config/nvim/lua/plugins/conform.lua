require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
	},
	format_on_save = {
		lsp_format = "never",
	},
})
