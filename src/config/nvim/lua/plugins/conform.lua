require("conform").setup({
	formatters = {
		["dioxus"] = {
			cmd = { "dx", "fmt", "--file", "$FILENAME" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "dioxus", "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
