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
		cmake = { "gersemi" },
		h = { "clang-format" },
		lua = { "stylua" },
		rust = { "dioxus", "rustfmt" },
		toml = { "taplo" },
		nix = { "nixfmt" },
		--web
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
