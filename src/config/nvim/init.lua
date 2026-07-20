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
