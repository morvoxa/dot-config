require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})
vim.notify = require("fidget").notify
require("fidget").setup({})
require("blink.indent").setup({})
vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					targetDir = true,
				},
			},
		},
	},
}
