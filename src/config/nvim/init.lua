if vim.g.vscode then
	-- System shared clipboard
	vim.opt.clipboard = "unnamedplus"
	vim.g.mapleader = " "

	local function vscode_action(key, action_id, description)
		vim.keymap.set("n", key, function()
			require("vscode").action(action_id)
		end, { silent = true, desc = description })
	end

	vscode_action("<leader>e", "workbench.view.explorer", "VSCode: Open Sidebar Explorer")
	vscode_action("<leader>w", "workbench.action.files.save", "VSCode: Save Active File")
	vscode_action("<leader>x", "workbench.action.closeActiveEditor", "VSCode: Close Active Tab")
	vscode_action("<leader>ff", "workbench.action.quickOpen", "VSCode: Find File (Quick Open)")
	vscode_action("<leader>c", "workbench.action.terminal.toggleTerminal", "VSCode: Toggle Integrated Terminal")
	vscode_action("<leader>l", "workbench.action.nextEditor", "VSCode: Next Tab / Editor")
	vscode_action("<leader>h", "workbench.action.previousEditor", "VSCode: Previous Tab / Editor")
else
	local o = vim.opt
	o.number = true
	o.tabstop = 4
	o.relativenumber = true
	o.clipboard = "unnamedplus"
	local map = vim.api.nvim_set_keymap
	vim.g.mapleader = " "
	map("i", "jk", "<esc>", {})
	map("n", "<leader>w", ":w<cr>", {})
	map("n", "<leader>c", ":!", {})
	map("n", "<leader>nh", ":nohl<cr>", {})
	map("n", "<leader>x", ":bdel<cr>", {})
	map("n", "<leader>ff", ":FzfLua files<cr>", {})
	vim.pack.add({
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
		{ src = "https://github.com/folke/tokyonight.nvim" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	})
	vim.cmd([[colorscheme tokyonight]])
	require("tree-sitter-manager").setup({
		auto_install = true,
		highlight = true,
	})
	require("nvim-autopairs").setup({})
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
			rust = { "rustfmt" },
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

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "never",
		},
		format_on_save = {
			lsp_format = false,
		},
	})
end
