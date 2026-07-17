return {
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
	}),
}
