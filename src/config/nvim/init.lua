if vim.g.vscode then
	local o = vim.opt
	o.clipboard = "unnamedplus"
	vim.g.mapleader = " "
	local vscode = require("vscode")

	local function vscode_map(mode, shortcut, vscode_command)
		vim.keymap.set(mode, shortcut, function()
			vscode.action(vscode_command)
		end, { silent = true })
	end
	vscode_map("n", "<leader>w", "workbench.action.files.save")
	vscode_map("n", "<leader>nh", "notifications.clearAll")
	vscode_map("n", "<leader>c", "workbench.action.terminal.toggleTerminal")
	vim.keymap.set("n", "<leader>nh", function()
		vim.cmd("nohlsearch")
		vscode.action("notifications.clearAll")
	end, { silent = true })
	vscode_map("n", "<leader>x", "workbench.action.closeActiveEditor")
	vscode_map("n", "<leader>p", "workbench.action.showCommands")
	vscode_map("n", "<leader>e", "workbench.view.explorer")
	vscode_map("n", "L", "workbench.action.nextEditor")
	vscode_map("n", "H", "workbench.action.previousEditor")
	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
	})
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
else
	-- =============================================================================
	-- 1. NEVIM BASIC OPTIONS
	-- =============================================================================
	local o = vim.opt

	o.number = true
	o.relativenumber = true
	o.tabstop = 4
	o.shiftwidth = 4
	o.splitright = true
	o.clipboard = "unnamedplus"

	vim.cmd([[colorscheme catppuccin]])

	-- =============================================================================
	-- 2. GLOBAL KEYMAPS
	-- =============================================================================
	vim.g.mapleader = " "
	local map = vim.api.nvim_set_keymap

	map("i", "jk", "<esc>", { silent = true })
	map("n", "<leader>w", ":w<cr>", { silent = true })
	map("n", "<leader>nh", ":nohl<cr>", { silent = true })
	map("n", "<leader>x", ":bdel<cr>", { silent = true })
	map("n", "<leader>e", ":Ex<cr>", { silent = false })
	map("n", "<leader>ff", ":FzfLua files<cr>", { silent = false })
	map("n", "<leader>c", ":belowright 15 split | term ", { silent = false })
	map("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
	map("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

	-- =============================================================================
	-- 3. PLUGIN INITIALIZATION & SETUP
	-- =============================================================================
	vim.pack.add({
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/folke/flash.nvim" },
		{ src = "https://github.com/ibhagwan/fzf-lua" },
		{ src = "https://github.com/j-hui/fidget.nvim" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/mrcjkb/rustaceanvim" },
		{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	})

	require("fidget").setup({})
	require("nvim-autopairs").setup({})

	require("tree-sitter-manager").setup({
		auto_install = true,
	})

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

	-- =============================================================================
	-- 4. FLASH KEYMAPS & SETUP
	-- =============================================================================
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

	-- =============================================================================
	-- 5. CONFORM FORMATTER SETUP
	-- =============================================================================
	require("conform").setup({
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			rust = { "rustfmt", "dioxus" },
			go = { "gofmt", "goimports" },
			zig = { "zigfmt" },
			nim = { "nimpretty" },
			java = { "google-java-format" },
			kotlin = { "ktlint" },
			d = { "dfmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			fish = { "fish_indent" },
			awk = { "awk" },
			perl = { "perltidy" },
			lua = { "stylua" },
			python = { "isort", "black" },
			ruby = { "rubocop" },
			php = { "php_cs_fixer" },
			cmake = { "gersemi" },
			make = { "checkmake" },
			dockerfile = { "hadolint" },
			nix = { "nixfmt" },
			terraform = { "terraform_fmt" },
			tf = { "terraform_fmt" },
			hcl = { "terragrunt_fmt" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			vue = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			less = { "prettierd" },
			html = { "prettierd" },
			graphql = { "prettierd" },
			blade = { "blade-formatter" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			yaml = { "prettierd" },
			toml = { "taplo" },
			ron = { "rustfmt" },
			xml = { "xmlformat" },
			ini = { "ini_formatter" },
			conf = { "ini_formatter" },
			env = { "dotenv-linter" },
			markdown = { "prettierd" },
			["markdown.mdx"] = { "prettierd" },
			sql = { "sql_formatter" },
		},
		formatters = {
			dioxus = {
				cmd = "dx",
				args = { "fmt", "--file", "$FILENAME" },
				stdin = false,
			},
		},
		format_on_save = {
			lsp_format = false,
		},
	})

	-- =============================================================================
	-- 6. STATUSLINE UTILITIES & DEFINITION
	-- =============================================================================
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

	local function get_lsp_status()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.bo[bufnr].filetype
		local bt = vim.bo[bufnr].buftype

		if ft == "" or bt ~= "" then
			return ""
		end

		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if #clients == 0 then
			return " [LSP: None]"
		end

		local lsp_names = {}
		for _, client in ipairs(clients) do
			table.insert(lsp_names, client.name)
		end

		return " [LSP: " .. table.concat(lsp_names, ", ") .. "]"
	end

	function MyStatusLine()
		local file_name = " %f %M "
		local align = "%="
		local lsp_info = get_lsp_status()
		local fmt_info = get_formatter_status()
		local location = " %l:%c %P "

		return string.format("%s%s%s%s%s", file_name, align, lsp_info, fmt_info, location)
	end

	vim.opt.statusline = "%!v:lua.MyStatusLine()"

	-- =============================================================================
	-- 7. NATIVE LSP SERVICES SETUP
	-- =============================================================================
	vim.lsp.config("tailwindcss", {
		cmd = { "tailwindcss-language-server", "--stdio" },
		root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
		filetypes = {
			"html",
			"css",
			"scss",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"rust",
		},
		init_options = {
			userLanguages = {
				rust = "html",
			},
		},
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ [[rsx![\s\S]*?class:[ ]*"([^"]*)"]], "([^ \t\r\n(]+)" },
						{ [[class:[ ]*"([^"]*)"]], "([^ \t\r\n(]+)" },
					},
				},
			},
		},
	})
	vim.lsp.enable("tailwindcss")
	--npm install -g @fsouza/prettierd @tailwindcss/language-server prettier

	vim.lsp.config("lua_ls", {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_dir = vim.fs.dirname(vim.fs.find({ ".git", ".luarc.json", "init.lua" }, { upward = true })[1]),
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						vim.fn.stdpath("config") .. "/lua",
					},
				},
				telemetry = { enable = false },
			},
		},
	})
	vim.lsp.enable("lua_ls")

	vim.lsp.config("clangd", {
		filetypes = { "c", "cpp", "h", "hpp", "cppm" },
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--fallback-style=-std=c++20",
			"-j=4",
			"--malloc-trim",
			"--pch-storage=memory",
			"--limit-results=50",
			"--limit-references=500",
			"--enable-config",
		},
		root_dir = vim.fs.dirname(
			vim.fs.find({ ".git", "compile_commands.json", "compile_flags.txt", "main.cpp" }, { upward = true })[1]
		),
	})
	vim.lsp.enable("clangd")

	-- =============================================================================
	-- 8. TOGGLE LAPS & INTERACTIVE FEATURES
	-- =============================================================================
	vim.keymap.set("n", "<leader>h", function()
		local is_hint_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
		vim.lsp.inlay_hint.enable(not is_hint_enabled, { bufnr = 0 })

		local config = vim.diagnostic.config()
		local is_virtual_text_enabled = config and config.virtual_text

		vim.diagnostic.config({
			virtual_text = not is_virtual_text_enabled,
		})

		if not is_hint_enabled then
			vim.notify("UI Hints & Errors: VISIBLE", vim.log.levels.INFO)
		else
			vim.notify("UI Hints & Errors: HIDDEN", vim.log.levels.WARN)
		end
	end, { desc = "Toggle Inlay Hints & Virtual Text" })
end
