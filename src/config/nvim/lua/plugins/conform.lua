vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	formatters_by_ft = {
		-- C / C++ & Headers
		c = { "clang-format" },
		cpp = { "clang-format" },
		h = { "clang-format" },
		hpp = { "clang-format" },
		objc = { "clang-format" },
		objcpp = { "clang-format" },

		-- Web Development (Frontend & Backend)
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		less = { "prettierd" },
		graphql = { "prettierd" },
		vue = { "prettierd" },
		svelte = { "prettierd" },
		astro = { "prettierd" },

		-- Systems & Backend Languages
		lua = { "stylua" },
		rust = { "rustfmt", "dioxus" },
		go = { "gofmt" },
		python = { "ruff_format" },
		cs = { "csharpier" },
		java = { "google-java-format" },
		kotlin = { "ktlint" },
		zig = { "zigfmt" },

		-- Data, Config, & Markup
		yaml = { "prettierd" },
		toml = { "taplo" },
		nix = { "nixfmt" },
		markdown = { "prettierd" },
		mdx = { "prettierd" },
		kdl = { "kdlfmt" },

		-- Shell & DevOps
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		fish = { "fish_indent" },
		dockerfile = { "hadolint" },
		terraform = { "terraform_fmt" },

		-- Other Languages
		ruby = { "rubocop" },
		elixir = { "mix" },
		sql = { "sql_formatter" },
		dart = { "dart_format" },
	},
	formatters = {
		dioxus = {
			command = "dx",
			args = { "fmt", "--file", "$FILENAME" },
			stdin = false, -- dx fmt mengubah file langsung, bukan lewat stdin
		},
	},

	format_on_save = {
		lsp_format = false,
	},
})
