vim.notify = require("fidget").notify
require("fidget").setup({})
require("luasnip.loaders.from_vscode").load({})
require("nvim-autopairs").setup({})
require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})

vim.keymap.set("n", "<Leader>e", ":Neotree toggle right<CR>", {
	silent = true,
	desc = "Toggle Neo-tree Sidebar Kanan",
})
