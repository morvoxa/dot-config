local k = vim.api.nvim_set_keymap
local o = vim.opt
o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.mouse = "a"
o.cursorline = true
o.wrap = false
o.scrolloff = 8
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.colorcolumn = "80"
o.signcolumn = "yes"
o.termguicolors = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.splitright = true
o.splitbelow = true
o.undofile = true

vim.g.mapleader = " "
k("i", "jk", "<Esc>", {})
k("n", "<leader>w", ":w<cr>", {})
k("n", "<leader>x", ":bdel<cr>", {})
k("n", "<leader>e", ":Ex<cr>", {})
k("n", "<leader>1", "<C-w>w", {})
k("n", "<leader>ff", ":FzfLua files<cr>", {})

local function toggle_lsp_features()
	local current_buf = vim.api.nvim_get_current_buf()
	local diagnostics_enabled = vim.diagnostic.is_enabled()
	local inlay_hints_enabled = false

	if vim.lsp.inlay_hint then
		inlay_hints_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = current_buf })
	end

	local target_state = not (diagnostics_enabled or inlay_hints_enabled)

	vim.diagnostic.enable(target_state)

	if target_state then
		vim.diagnostic.config({ virtual_text = true, signs = true })
	end

	local hint_status = ""
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(target_state, { bufnr = current_buf })
		hint_status = target_state and " & Hints Enabled" or " & Hints Disabled"
	end

	local msg = target_state and "LSP Features: ENABLED" or "LSP Features: DISABLED"
	vim.notify(msg .. hint_status, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>hh", toggle_lsp_features, { desc = "Toggle LSP Diagnostics & Inlay Hints" })
vim.pack.add({
	{ src = "https://github.com/jiangmiao/auto-pairs" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})
vim.cmd([[colorscheme catppuccin]])
require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})
vim.notify = require("fidget").notify
require("fidget").setup({})

require("blink.cmp").setup({
	keymap = { preset = "default" },

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
require("conform").setup({
	formatters = {
		["dioxus"] = {
			cmd = { "dx", "fmt", "--file", "$FILENAME" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "dioxus", "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
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

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("tailwindcss")
