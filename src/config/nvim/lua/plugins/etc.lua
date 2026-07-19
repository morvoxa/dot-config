require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})
vim.notify = require("fidget").notify
require("fidget").setup({})
require("blink.indent").setup({})
