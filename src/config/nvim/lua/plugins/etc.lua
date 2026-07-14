local notify = require("notify")
notify.setup({
	stages = "static",
	timeout = 1500,
	max_width = 50,
})
vim.notify = notify
require("fidget").setup({})
require("luasnip.loaders.from_vscode").load({})
require("nvim-autopairs").setup({})
require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})
