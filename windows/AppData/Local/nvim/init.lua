vim.env.CC = "gcc"
vim.cmd([[colorscheme retrobox]])
local o = vim.opt
local k = vim.keymap
vim.g.mapleader = " "

-- 1. LOAD PLUGINS FIRST
vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim.git" },
})
require("tree-sitter-manager").setup({
	auto_install = true,
	highlight = true,
})

local notify = require("notify")
notify.setup({
	stages = "static",
	timeout = 1500,
	max_width = 50,
})
vim.notify = notify
require("nvim-autopairs").setup({})

-- 2. FLASH KEYMAPS
k.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
k.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
k.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
k.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
k.set("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- 3. NEOVIM OPTIONS
o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.termguicolors = true
o.splitright = true
o.clipboard = "unnamedplus"
o.signcolumn = "yes"
o.updatetime = 250
o.timeoutlen = 300
o.scrolloff = 8
o.autoread = true
o.swapfile = false
o.backup = false

-- 4. GENERAL KEYMAPS
k.set("i", "jk", "<esc>", { desc = "Keluar dari mode insert dengan cepat" })
k.set("n", "<leader>w", ":w<cr>", { desc = "Simpan file" })
k.set("n", "<leader>nh", ":nohl<cr>", { desc = "Hapus sorotan pencarian" })
k.set("n", "<leader>x", ":bdel<cr>", { desc = "Tutup buffer/tab aktif" })
k.set("n", "<leader>e", ":Ex<cr>", { desc = "Buka file explorer bawaan (Netrw)" })
k.set("n", "<leader>ff", ":FzfLua files<cr>", { desc = "Cari file pakai FzfLua" }) -- Fixed desc
k.set("n", "<leader>c", ":belowright 15 split | term ", { desc = "Buka terminal di bawah" })
k.set("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
k.set("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

-- 5. ENGINE FORMATTER
local formatters = {
	cpp = "clang-format --style=Google",
	hpp = "clang-format --style=Google",
	c = "clang-format --style=Google",
	h = "clang-format --style=Google",
	rs = "rustfmt",
	lua = "stylua -",
	ts = "prettierd %",
	tsx = "prettierd %",
	js = "prettierd %",
	jsx = "prettierd %",
	css = "prettierd %",
	json = "prettierd %",
}

local function run_formatter(opts)
	local ext = vim.fn.expand("%:e")
	local cmd = formatters[ext]
	if not cmd then
		if opts and opts.manual then
			vim.notify("No formatter configured for ." .. ext, vim.log.levels.WARN, { title = "Formatter" })
		end
		return
	end

	local view = vim.fn.winsaveview()
	vim.cmd("silent %!" .. cmd)

	if vim.v.shell_error ~= 0 then
		vim.cmd("silent undo")
		vim.notify(
			"Failed to format ." .. ext .. " (Syntax error or missing tool)",
			vim.log.levels.ERROR,
			{ title = "Formatter Error" }
		)
	else
		-- FIXED: Removed the manual check restriction so it pops up every single time you save
		vim.notify("File formatted successfully!", vim.log.levels.INFO, { title = "Formatter" })
	end

	vim.fn.winrestview(view)
end

-- Triggers
local fmt_group = vim.api.nvim_create_augroup("CustomFormatterGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = fmt_group,
	pattern = "*",
	callback = function()
		run_formatter({ manual = false })
	end,
})

vim.api.nvim_create_user_command("FF", function()
	run_formatter({ manual = true })
end, {})
