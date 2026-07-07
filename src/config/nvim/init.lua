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
	require("options")
	require("keymaps")
	require("statusline")
	require("colorscheme")
	require("plugins.conform")
	require("plugins.fidget")
	require("plugins.tree-sitter")
	require("plugins.autopairs")
	require("plugins.snacks")
	require("plugins.blink")
	require("plugins.rust")
	require("plugins.explorer")
	require("lsp.lua_ls")
end
