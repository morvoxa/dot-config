return {
	vim.lsp.config("tailwindcss", {
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = { "html", "css", "rust" }, -- Menambahkan dukungan file Rust

		-- KUNCI UTAMA: Biarkan Neovim native yang mencari folder .git secara otomatis!
		root_markers = { ".git" },

		init_options = {
			userLanguages = {
				rust = "html",
			},
		},

		settings = {
			tailwindCSS = {
				includeLanguages = {
					rust = "html", -- Sesuai permintaan Anda
				},
				experimental = {
					classRegex = {
						'class: "([^"]*)"', -- Format regex murni untuk mencocokkan class: "(.*)"
					},
				},
			},
		},
	}),
}
--npm install -g @tailwindcss/language-server
