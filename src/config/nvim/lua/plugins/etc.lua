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
require("luasnip.loaders.from_vscode").lazy_load()
require("oil").setup({
	float = {
		padding = 0,
		border = "rounded",

		override = function(conf)
			local total_cols = vim.o.columns
			local width = math.floor(total_cols * 0.35)
			local total_lines = vim.o.lines
			local height = math.floor(total_lines * 0.85) -- Adjust 0.85 to change vertical size
			local row = math.floor((total_lines - height) / 2)
			conf.row = row
			conf.col = total_cols - width - 2
			conf.width = width
			conf.height = height
			return conf
		end,
	},
})
