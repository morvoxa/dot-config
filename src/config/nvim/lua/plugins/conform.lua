require("conform").setup({
	formatters = {
		["dioxus"] = {
			cmd = { "dx", "fmt", "--file", "$FILENAME" },
		},
		["clang-format"] = {
			prepend_args = { "--style=Google" },
		},
	},
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		h = { "clang-format" },
		lua = { "stylua" },
		rust = { "dioxus", "rustfmt" },
		toml = { "taplo" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
