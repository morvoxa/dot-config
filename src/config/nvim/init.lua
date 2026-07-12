if vim.g.vscode then
	local o = vim.opt
	o.clipboard = "unnamedplus"
	vim.g.mapleader = " "

	local vscode = require("vscode")
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
end
