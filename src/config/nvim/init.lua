if vim.g.vscode then
	local o = vim.opt
	o.clipboard = "unnamedplus"
	o.ignorecase = true
	o.smartcase = true
	o.incsearch = true
	vim.g.mapleader = " "

	local vscode = require("vscode")
	vim.notify = vscode.notify
	local function vscode_map(mode, shortcut, vscode_command)
		vim.keymap.set(mode, shortcut, function()
			vscode.action(vscode_command)
		end, { silent = true })
	end

	vscode_map("n", "<leader>w", "workbench.action.files.save")
	vscode_map("n", "<leader>c", "workbench.action.terminal.toggleTerminal")
	vscode_map("n", "<leader>x", "workbench.action.closeActiveEditor")
	vscode_map("n", "<leader>p", "workbench.action.showCommands")
	vscode_map("n", "<leader>e", "workbench.view.explorer")
	vscode_map("n", "L", "workbench.action.nextEditor")
	vscode_map("n", "H", "workbench.action.previousEditor")
	vim.keymap.set("n", "<leader>nh", function()
		vim.cmd("nohlsearch")
		vscode.action("notifications.clearAll")
	end, { silent = true })

	vim.pack.add({ { src = "https://github.com/folke/flash.nvim" } })
	require("flash").setup({})
	local flash = require("flash")
	local flash_maps = {
		[{ "n", "x", "o" }] = { { "s", flash.jump, "Flash" }, { "S", flash.treesitter, "Flash Treesitter" } },
		[{ "x", "o" }] = { { "R", flash.treesitter_search, "Treesitter Search" } },
		[{ "o" }] = { { "r", flash.remote, "Remote Flash" } },
		[{ "c" }] = { { "<c-s>", flash.toggle, "Toggle Flash Search" } },
	}

	for modes, maps in pairs(flash_maps) do
		for _, map in ipairs(maps) do
			vim.keymap.set(modes, map[1], map[2], { desc = map[3] })
		end
	end
else
	-- ========================================================================== --
	-- 1. PENGATURAN AWAL & LEADER KEY
	-- ========================================================================== --
	vim.g.mapleader = " "
	local o = vim.opt
	local k = vim.keymap

	-- ========================================================================== --
	-- 2. MANAJEMEN PLUGIN (Instalasi)
	-- ========================================================================== --
	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
		{ src = "https://github.com/j-hui/fidget.nvim" },
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/L3MON4D3/LuaSnip" },
		{ src = "https://github.com/rafamadriz/friendly-snippets" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
		{ src = "https://github.com/rcarriga/nvim-notify" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim.git" },
	})
	-- Snippets
	require("luasnip.loaders.from_vscode").load({})

	-- Tema / Colorscheme
	vim.cmd([[colorscheme catppuccin]])

	-- ========================================================================== --
	-- 3. KONFIGURASI NATIVE VIM (vim.opt)
	-- ========================================================================== --
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

	-- ========================================================================== --
	-- 4. PEMETAAN TOMBOL GLOBAL (vim.keymap)
	-- ========================================================================== --
	-- Mode Navigasi & Berkas
	k.set("i", "jk", "<esc>", { desc = "Keluar dari mode insert dengan cepat" })
	k.set("n", "<leader>w", ":w<cr>", { desc = "Simpan file" })
	k.set("n", "<leader>nh", ":nohl<cr>", { desc = "Hapus sorotan pencarian" })
	k.set("n", "<leader>x", ":bdel<cr>", { desc = "Tutup buffer/tab aktif" })
	k.set("n", "<leader>e", ":Ex<cr>", { desc = "Buka file explorer bawaan (Netrw)" })
	k.set("n", "<leader>c", ":belowright 15 split | term ", { desc = "Buka terminal di bawah" })

	-- Indentasi Mode Visual
	k.set("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
	k.set("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

	-- Integrasi Plugin (FzfLua & Flash)
	k.set("n", "<leader>ff", ":FzfLua files<cr>", { desc = "Cari file pakai FzfLua" })
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

	-- ========================================================================== --
	-- 5. KONFIGURASI PLUGIN & LSP SETUP
	-- ========================================================================== --
	-- Notification System
	local notify = require("notify")
	notify.setup({
		stages = "static",
		timeout = 1500,
		max_width = 50,
	})
	vim.notify = notify

	-- Fidget (LSP Status)
	require("fidget").setup({})

	-- Autopairs
	require("nvim-autopairs").setup({})

	-- Tree-sitter Manager
	require("tree-sitter-manager").setup({
		auto_install = true,
		highlight = true,
	})

	-- Conform (Formatter)
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			h = { "clang-format" },
			rust = { "rustfmt" },
			toml = { "taplo" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			less = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			graphql = { "prettierd" },
			vue = { "prettierd" },
		},
		format_on_save = {
			lsp_format = "never",
		},
	})

	-- Blink.cmp (Completion)
	require("blink.cmp").setup({
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = false },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	})

	-- Built-in LSP Servers
	vim.lsp.enable("clangd")
	vim.lsp.enable("lua_ls")
end
