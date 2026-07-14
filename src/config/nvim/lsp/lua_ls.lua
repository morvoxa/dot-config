return {
	vim.lsp.config("lua_ls", {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_makers = {
			".git",
		},
		settings = {
			Lua = {
				hint = { enable = true },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
	}),
}
