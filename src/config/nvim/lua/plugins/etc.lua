vim.notify = require("fidget").notify
require("fidget").setup({})
require("luasnip.loaders.from_vscode").load({})
require("nvim-autopairs").setup({})
require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})
