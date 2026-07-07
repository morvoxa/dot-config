vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
require("blink.cmp").setup({
	keymap = { preset = "default" },
	completion = { documentation = { auto_show = false } },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	fuzzy = { implementation = "rust" },
})
