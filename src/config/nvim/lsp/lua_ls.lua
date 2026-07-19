return {
	vim.lsp.config("lua_ls", {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "describe", "it", "before_each", "after_each" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	}),
}
