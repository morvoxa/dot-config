local o = vim.opt
local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "
--========================================================
o.number = true
o.tabstop = 4
o.relativenumber = true
o.clipboard = "unnamedplus"
--========================================================
map("i", "jk", "<esc>", {})
map("n", "<leader>w", ":w<cr>", {})
map("n", "<leader>nh", ":nohl<cr>", {})
map("n", "<leader>x", ":bdel<cr>", {})
map("n", "<leader>c", ":!", {})
vim.keymap.set("n", "<leader>hh", function()
	if vim.lsp.inlay_hint then
		local current_buf = vim.api.nvim_get_current_buf()
		local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = current_buf })
		vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = current_buf })
	end

	local diagnostics_config = vim.diagnostic.config()
	local virtual_text_enabled = true

	if diagnostics_config and diagnostics_config.virtual_text == false then
		virtual_text_enabled = false
	end

	vim.diagnostic.config({
		virtual_text = not virtual_text_enabled,
	})

	local status = not virtual_text_enabled and "ON" or "OFF"
	vim.notify("LSP Hints & Errors: " .. status, vim.log.levels.INFO)
end, { desc = "Toggle LSP Inlay Hints and Virtual Text" })
--========================================================
vim.cmd([[colorscheme industry]])
vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim", version = "v1.0.0" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
})
require("fidget").setup({})
--========================================================
require("tree-sitter-manager").setup({
	auto_install = true,
})
--========================================================
require("luasnip.loaders.from_vscode").load({})
--========================================================
require("flash").setup({})
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
--========================================================

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = false } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
--========================================================
require("nvim-autopairs").setup({})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		cmake = { "gersemi" },
		zig = { "zigfmt" },
	},
	format_on_save = {
		lsp_format = false,
	},
})

--========================================================
map("n", "<leader>ff", ":lua Snacks.picker.files()<cr>", {})
require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})
--========================================================
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	init_options = {
		fallbackFlags = { "-std=c++20" },
	},
})
--========================================================
vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	workspace_required = false,
})

--========================================================
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})
--========================================================
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("zls")
--========================================================

local function get_status_components()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype

	if ft == "" or vim.bo[bufnr].buftype ~= "" then
		return "", ""
	end

	local lsp_list = {}
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in pairs(clients) do
		table.insert(lsp_list, client.name)
	end

	local lsp_string = ""
	if #lsp_list > 0 then
		lsp_string = " ▲ {" .. table.concat(lsp_list, ", ") .. "}"
	else
		lsp_string = " [!] {!No LSP}"
	end

	local fmt_list = {}
	local status, conform = pcall(require, "conform")
	if status then
		local formatters = conform.list_formatters(bufnr)
		for _, f in ipairs(formatters) do
			table.insert(fmt_list, f.name)
		end
	end

	local fmt_string = ""
	if #fmt_list > 0 then
		fmt_string = " ▼ {" .. table.concat(fmt_list, ", ") .. "}"
	else
		fmt_string = " [!] {!No Formatter}"
	end

	return lsp_string, fmt_string
end

function MyStatusLine()
	local file_name = " %f %M "
	local align = "%=" -- Geser ke kanan

	local lsp_info, fmt_info = get_status_components()
	local location = " %l:%c %P "

	return string.format("%s%s%s%s%s", file_name, align, lsp_info, fmt_info, location)
end

vim.opt.statusline = "%!v:lua.MyStatusLine()"

--========================================================
vim.api.nvim_create_user_command("Bld", function()
	vim.cmd("write") -- Otomatis simpan file

	local has_build = vim.fn.isdirectory("build") == 1
	local cmd = ""

	-- 1. Deteksi Sistem Operasi & Tentukan Path Executable
	local is_windows = vim.fn.has("win32") == 1
	local exe_path = ""

	if is_windows then
		exe_path = ".\\build\\Debug\\Oop.exe"
	else
		exe_path = "./build/Oop" -- Standar Linux / macOS
	end

	-- 2. Cek waktu modifikasi terakhir CMakeLists.txt vs folder build
	local cmake_time = vim.fn.getftime("CMakeLists.txt")
	local build_time = vim.fn.getftime("build")

	-- 3. Susun perintah berdasarkan kondisi file & OS
	if not has_build or (cmake_time > build_time) then
		-- Jika build belum ada atau CMakeLists.txt berubah: Konfigurasi ulang -> Compile -> Run
		cmd = "cmake -B build && cmake --build build && " .. exe_path
	else
		-- Jika aman, langsung Compile -> Run
		cmd = "cmake --build build && " .. exe_path
	end

	-- 4. Jalankan di terminal internal Neovim
	vim.cmd("vsplit | terminal " .. cmd)
	vim.cmd("startinsert")
end, {})
