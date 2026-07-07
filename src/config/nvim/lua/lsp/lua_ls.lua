vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			hint = { enable = true },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("tailwindcss", {
	filetypes = {
		"html",
		"css",
		"javascript",
		"typescript",
		"react",
		"rust",
	},

	init_options = {
		userLanguages = {
			rust = "html",
		},
	},

	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					-- Mencari pola class: "..." di dalam file rust
					[[class:\s*"([^"]*)"]],
					[[classname:\s*"([^"]*)"]],
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("tailwindcss")
