local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ "folke/tokyonight.nvim" },
	{ "windwp/nvim-autopairs" },
	{
		"saghen/blink.cmp",
		version = "v1.10.2",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "neovim/nvim-lspconfig" },
		},
	},
	{ "stevearc/conform.nvim" },
	{ "j-hui/fidget.nvim" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "mrcjkb/rustaceanvim" },
	{ "folke/snacks.nvim" },
	{ "romus204/tree-sitter-manager.nvim" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
})
