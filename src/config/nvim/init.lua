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
	map("n", "<leader>x", ":bdel<cr>", {})
	map("n", "<leader>ff", ":FzfLua files<cr>", {})
	vim.pack.add({
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
	})
	vim.cmd([[colorscheme retrobox]])
	require("nvim-autopairs").setup({})
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			nix = { "nixfmt" },
			toml = { "taplo" },
		},
		format_on_save = {
			lsp_format = false,
		},
	})
end
