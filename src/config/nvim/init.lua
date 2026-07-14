if vim.g.vscode then
	local o = vim.opt
	o.clipboard = "unnamedplus"
	o.ignorecase = true
	o.smartcase = true
	o.incsearch = true
	vim.g.mapleader = " "

	local vscode = require("vscode")
	vim.notify = vscode.notify
	local function vscode_map(mode, shortcut, vscode_command)
		vim.keymap.set(mode, shortcut, function()
			vscode.action(vscode_command)
		end, { silent = true })
	end

	vscode_map("n", "<leader>w", "workbench.action.files.save")
	vscode_map("n", "<leader>c", "workbench.action.terminal.toggleTerminal")
	vscode_map("n", "<leader>x", "workbench.action.closeActiveEditor")
	vscode_map("n", "<leader>p", "workbench.action.showCommands")
	vscode_map("n", "<leader>e", "workbench.view.explorer")
	vscode_map("n", "L", "workbench.action.nextEditor")
	vscode_map("n", "H", "workbench.action.previousEditor")
	vim.keymap.set("n", "<leader>nh", function()
		vim.cmd("nohlsearch")
		vscode.action("notifications.clearAll")
	end, { silent = true })

	vim.pack.add({ { src = "https://github.com/folke/flash.nvim" } })
	require("flash").setup({})
	local flash = require("flash")
	local flash_maps = {
		[{ "n", "x", "o" }] = { { "s", flash.jump, "Flash" }, { "S", flash.treesitter, "Flash Treesitter" } },
		[{ "x", "o" }] = { { "R", flash.treesitter_search, "Treesitter Search" } },
		[{ "o" }] = { { "r", flash.remote, "Remote Flash" } },
		[{ "c" }] = { { "<c-s>", flash.toggle, "Toggle Flash Search" } },
	}

	for modes, maps in pairs(flash_maps) do
		for _, map in ipairs(maps) do
			vim.keymap.set(modes, map[1], map[2], { desc = map[3] })
		end
	end
else
	require("keymap")
	vim.cmd([[colorscheme catppuccin]])
	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
		{ src = "https://github.com/j-hui/fidget.nvim" },
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/L3MON4D3/LuaSnip" },
		{ src = "https://github.com/rafamadriz/friendly-snippets" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
		{ src = "https://github.com/rcarriga/nvim-notify" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim.git" },
	})
	require("plugins.conform")
	require("plugins.blink")
	require("plugins.etc")
	vim.lsp.enable("clangd")
	vim.lsp.enable("lua_ls")
end
