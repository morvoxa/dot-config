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
})

require("keymap")
require("opt")
require("plugins.conform")
require("plugins.blink")
require("plugins.etc")

vim.cmd([[colorscheme catppuccin]])

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("tailwindcss")
