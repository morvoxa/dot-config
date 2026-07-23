if vim.g.vscode then
	local o = vim.opt
	o.clipboard, o.ignorecase, o.smartcase, o.incsearch = "unnamedplus", true, true, true
	vim.g.mapleader = " "

	local vscode = require("vscode")
	vim.notify = vscode.notify

	local function map(mode, key, cmd)
		vim.keymap.set(mode, key, function()
			vscode.action(cmd)
		end, { silent = true })
	end

	map("n", "<leader>w", "workbench.action.files.save")
	map("n", "<leader>c", "workbench.action.terminal.toggleTerminal")
	map("n", "<leader>x", "workbench.action.closeActiveEditor")
	map("n", "<leader>p", "workbench.action.showCommands")
	map("n", "<leader>e", "workbench.view.explorer")
	map("n", "L", "workbench.action.nextEditor")
	map("n", "H", "workbench.action.previousEditor")
	map("n", "<leader>nh", function()
		vim.cmd.nohlsearch()
		vscode.action("notifications.clearAll")
	end)

	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
	})
	local flash = require("flash")
	flash.setup({})

	vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
	vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
	vim.keymap.set({ "x", "o" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
	vim.keymap.set("o", "r", flash.remote, { desc = "Remote Flash" })
	vim.keymap.set("c", "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })
else
	vim.pack.add({
		{ src = "https://github.com/jiangmiao/auto-pairs" },
		{ src = "https://github.com/folke/flash.nvim" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
		{ src = "https://github.com/mrcjkb/rustaceanvim" },
		{ src = "https://github.com/j-hui/fidget.nvim" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
		{ src = "https://github.com/saghen/blink.indent" },
		{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/L3MON4D3/LuaSnip" },
		{ src = "https://github.com/rafamadriz/friendly-snippets" },
		{ src = "https://github.com/stevearc/oil.nvim" },
	})

	require("keymap")
	require("opt")
	require("status")
	require("plugins.conform")
	require("plugins.blink")
	require("plugins.etc")

	vim.cmd([[colorscheme catppuccin]])

	vim.lsp.enable("clangd")
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("tailwindcss")
	local nextjs_servers = {
		"vtsls",
		"eslint",
		"emmet_ls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
	}
	--npm install -g @vtsls/language-server eslint emmet-ls vscode-langservers-extracted yaml-language-server @tailwindcss/language-server
	for _, lsp in ipairs(nextjs_servers) do
		vim.lsp.enable(lsp)
	end
end
