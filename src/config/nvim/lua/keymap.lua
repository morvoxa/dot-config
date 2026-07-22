local k = vim.api.nvim_set_keymap
vim.g.mapleader = " "
k("i", "jk", "<Esc>", {})
k("n", "<leader>w", ":w<cr>", {})
k("n", "<leader>x", ":bdel<cr>", {})
k("n", "<leader>e", ":Oil<cr>", {})
k("n", "<leader>1", "<C-w>w", {})
k("n", "<leader>ff", ":FzfLua files<cr>", {})

local function toggle_lsp_features()
	local current_buf = vim.api.nvim_get_current_buf()

	local current_config = vim.diagnostic.config()
	local virtual_text_enabled = current_config and current_config.virtual_text ~= false

	local target_state = not virtual_text_enabled

	vim.diagnostic.config({
		virtual_text = target_state,
		signs = true,
	})

	local hint_status = ""
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(target_state, { bufnr = current_buf })
		hint_status = target_state and " & Hints Enabled" or " & Hints Disabled"
	end

	local msg = target_state and "LSP Text: ENABLED" or "LSP Text: DISABLED"
	vim.notify(msg .. hint_status, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>hh", toggle_lsp_features, { desc = "Toggle LSP Diagnostics & Inlay Hints" })

local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	flash.remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
	flash.treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
	flash.toggle()
end, { desc = "Toggle Flash Search" })
