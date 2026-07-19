require("conform").setup({
	formatters = {
		["clang-format"] = {
			prepend_args = { "--style=Google" },
		},
		["dioxus"] = {
			cmd = { "dx", "fmt", "--file", "$FILENAME" },
		},
	},
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		h = { "clang-format" },
		lua = { "stylua" },
		rust = { "dioxus", "rustfmt" },
		toml = { "taplo" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		css = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
	},
	format_on_save = {
		lsp_format = "never",
	},
})
