return {
	vim.lsp.config("tailwindcss", {
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"html",
			"css",
			"scss",
			"sass",
			"javascriptreact",
			"typescriptreact",
			"javascript",
			"typescript",
			"rust",
		},

		root_markers = { ".git" },

		init_options = {
			userLanguages = {
				rust = "html",
			},
		},

		settings = {
			tailwindCSS = {
				includeLanguages = {
					rust = "html",
				},
				experimental = {
					classRegex = {
						'class: "([^"]*)"',
						'className= {"([^"]*)" }',
						"className= {`([^`]*)` }",
					},
				},
			},
		},
	}),
}
