local o = vim.opt
local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "
--========================================================
o.number = true
o.tabstop = 4
o.shiftwidth = 4
o.relativenumber = true
o.splitright = true
o.clipboard = "unnamedplus"
vim.cmd([[colorscheme catppuccin]])
--========================================================
map("i", "jk", "<esc>", {})
map("n", "<leader>w", ":w<cr>", {})
map("n", "<leader>nh", ":nohl<cr>", {})
map("n", "<leader>x", ":bdel<cr>", {})
map("n", "<leader>c", ":belowright 15 split | term ", { silent = false })
map("n", "<leader>ff", ":FzfLua files<cr>", { silent = false })
map("n", "<leader>e", ":Ex<cr>", { silent = false })
map("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
map("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

--========================================================
require("tree-sitter-manager").setup({
	auto_install = true,
})
--========================================================
require("nvim-autopairs").setup({})
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
require("conform").setup({
	formatters_by_ft = {
		-- ========================================================
		-- 1. COMPILED & SYSTEM LANGUAGES
		-- ========================================================
		c = { "clang-format" },
		cpp = { "clang-format" },
		rust = { "rustfmt" },
		go = { "gofmt", "goimports" },
		zig = { "zigfmt" },
		nim = { "nimpretty" },
		java = { "google-java-format" },
		kotlin = { "ktlint" },
		d = { "dfmt" },

		-- ========================================================
		-- 2. SCRIPTING, AUTOMATION & LINUX SHELL
		-- ========================================================
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		fish = { "fish_indent" },
		awk = { "awk" },
		perl = { "perltidy" },

		-- ========================================================
		-- 3. BACKEND & SCRIPTING LANGUAGES
		-- ========================================================
		lua = { "stylua" },
		python = { "isort", "black" }, -- Runs isort (imports) first, then black
		ruby = { "rubocop" },
		php = { "php_cs_fixer" },

		-- ========================================================
		-- 4. DEVOPS, BUILD TOOLS & LINUX SYSTEM CONFIGS
		-- ========================================================
		cmake = { "gersemi" },
		make = { "checkmake" },
		dockerfile = { "hadolint" },
		nix = { "nixfmt" },
		terraform = { "terraform_fmt" },
		tf = { "terraform_fmt" },
		hcl = { "terragrunt_fmt" },

		-- ========================================================
		-- 5. WEB DEVELOPMENT (Frontend, JavaScript & Templates)
		-- ========================================================
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		less = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		graphql = { "prettierd", "prettier", stop_after_first = true },
		blade = { "blade-formatter" },

		-- ========================================================
		-- 6. DATA, SERIALIZATION & CONFIGURATION FILES
		-- ========================================================
		json = { "prettierd", "prettier", stop_after_first = true },
		jsonc = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		toml = { "taplo" },
		ron = { "rustfmt" },
		xml = { "xmlformat" },
		ini = { "ini_formatter" }, -- Common for Linux .ini and .conf files
		conf = { "ini_formatter" },
		env = { "dotenv-linter" }, -- .env files

		-- ========================================================
		-- 7. DOCUMENTATION, NOTES & DATABASES
		-- ========================================================
		markdown = { "prettierd", "prettier", stop_after_first = true },
		["markdown.mdx"] = { "prettierd", "prettier", stop_after_first = true },
		sql = { "sql_formatter" },
	},
	format_on_save = {
		lsp_format = false,
	},
})
--========================================================
local function get_formatter_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype

	if ft == "" or vim.bo[bufnr].buftype ~= "" then
		return ""
	end

	local status, conform = pcall(require, "conform")
	if not status then
		return ""
	end

	local active_fmts = {}
	local missing_fmts = {}

	local formatters = conform.list_formatters(bufnr)
	local fmt_names = {}

	for _, f in ipairs(formatters) do
		table.insert(fmt_names, f.name)
	end

	if #fmt_names == 0 and conform.formatters_by_ft then
		local configured = conform.formatters_by_ft[ft]
		if configured then
			if type(configured) == "string" then
				table.insert(fmt_names, configured)
			elseif type(configured) == "table" then
				for _, name in ipairs(configured) do
					table.insert(fmt_names, name)
				end
			end
		end
	end

	for _, name in ipairs(fmt_names) do
		local info = conform.get_formatter_info(name, bufnr)

		if info and info.available then
			table.insert(active_fmts, name .. " active")
		else
			table.insert(missing_fmts, name .. " not found")
		end
	end

	if #active_fmts > 0 or #missing_fmts > 0 then
		local all_status = {}
		for _, v in ipairs(active_fmts) do
			table.insert(all_status, v)
		end
		for _, v in ipairs(missing_fmts) do
			table.insert(all_status, v)
		end

		return " ▼ {" .. table.concat(all_status, ", ") .. "}"
	else
		return " [!] {!No Formatter Configured}"
	end
end

function MyStatusLine()
	local file_name = " %f %M "
	local align = "%="
	local fmt_info = get_formatter_status()
	local location = " %l:%c %P "

	return string.format("%s%s%s%s", file_name, align, fmt_info, location)
end

vim.opt.statusline = "%!v:lua.MyStatusLine()"
--========================================================
