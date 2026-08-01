if vim.g.vscode then
  vim.o.relativenumber = true
  vim.o.number = true
  vim.o.clipboard = "unnamedplus"
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.hlsearch = true
  vim.o.incsearch = true
  vim.o.scrolloff = 8
  vim.o.sidescrolloff = 8
  vim.o.whichwrap = "b,s,<,>,[,],h,l"
  vim.o.autoindent = true
  vim.o.smartindent = true
  vim.o.laststatus = 0

  local vscode = require("vscode")
  vim.g.mapleader = " "
  vim.keymap.set("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
  end, { desc = "Find Files" })

  vim.keymap.set("n", "<leader>w", function()
    vscode.action("workbench.action.files.save")
    vscode.notify("File saved successfully!")
  end, { desc = "Save File with Notification" })

  vim.keymap.set("n", "<leader>p", function()
    vscode.action("workbench.action.showCommands")
  end, { desc = "Command Palette" })

  vim.keymap.set("n", "<leader>t", function()
    vscode.action("workbench.action.terminal.toggleTerminal")
  end, { desc = "Toggle Terminal" })

  vim.keymap.set("n", "<leader>e", function()
    vscode.action("workbench.view.explorer")
  end, { desc = "Focus File Explorer" })

  vim.keymap.set("n", "<leader>c", function()
    vscode.action("workbench.action.closeActiveEditor")
  end, { desc = "Close File" })

  vim.keymap.set("n", "H", function()
    vscode.action("workbench.action.previousEditor")
  end, { desc = "Prev File" })

  vim.keymap.set("n", "L", function()
    vscode.action("workbench.action.nextEditor")
  end, { desc = "Next File" })

  vim.keymap.set("n", "<leader>nh", function()
    vim.cmd("noh")
    vscode.action("notifications.clearAll")
    vscode.action("notifications.hideList")
  end, { desc = "No Highlight & Clear Notifications" })
  vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
  })

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true, remap = false })
  end

  map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, "Flash")

  map({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
  end, "Flash Treesitter")

  map("o", "r", function()
    require("flash").remote()
  end, "Remote Flash")

  map({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
  end, "Treesitter Search")

  map("c", "<c-s>", function()
    require("flash").toggle()
  end, "Toggle Flash Search")
else
  vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/mrcjkb/rustaceanvim" },
    { src = "https://github.com/saghen/blink.cmp",     version = "v1.10.2" },
  })
  require("conform").setup({
    formatters_by_ft = {
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
  require("fidget").setup {
  }
  --lsp
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("taplo")
  vim.lsp.enable("slint_lsp")
  vim.lsp.enable("clangd")
  vim.o.relativenumber = true
  vim.o.number = true
  vim.o.clipboard = "unnamedplus"
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.hlsearch = true
  vim.o.incsearch = true
  vim.o.scrolloff = 8
  vim.o.sidescrolloff = 8
  vim.o.whichwrap = "b,s,<,>,[,],h,l"
  vim.o.autoindent = true
  vim.o.smartindent = true
  vim.o.laststatus = 0
  vim.o.tabstop = 2
  vim.o.shiftwidth = 4

  require("mini.basics").setup {}
  require("mini.pairs").setup {}
  require("mini.snippets").setup {}
  require("mini.pick").setup {}
  require("blink.cmp").setup {}

  vim.api.nvim_set_keymap("n", "<leader>ff", ":Pick files<cr>", { desc = "pick files" })
  vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>", { desc = "write" })
  vim.api.nvim_set_keymap("n", "<leader>c", ":bdel<cr>", { desc = "close buf" })
  vim.api.nvim_set_keymap("n", "<leader>1", "<C-w>w", { desc = "close buf" })
  vim.api.nvim_set_keymap("i", "jk", "<Esc>", { desc = "normal" })

  local opts = { noremap = true, silent = true }
  local function map(mode, lhs, rhs, desc)
    local options = vim.tbl_extend("force", opts, { desc = desc })
    if type(mode) == "table" then
      for _, m in ipairs(mode) do
        vim.api.nvim_set_keymap(m, lhs, rhs, options)
      end
    else
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
  end
  map({ "n", "x", "o" }, "s", "<cmd>lua require('flash').jump()<cr>", "Flash")
  map({ "n", "x", "o" }, "S", "<cmd>lua require('flash').treesitter()<cr>", "Flash Treesitter")
  map("o", "r", "<cmd>lua require('flash').remote()<cr>", "Remote Flash")
  map({ "o", "x" }, "R", "<cmd>lua require('flash').treesitter_search()<cr>", "Treesitter Search")
  map("c", "<c-s>", "<cmd>lua require('flash').toggle()<cr>", "Toggle Flash Search")
  vim.keymap.set("n", "<leader>hh", function()
    local bufnr = 0
    local hints_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not hints_enabled, { bufnr = bufnr })
    vim.diagnostic.config({
      virtual_text = not hints_enabled,
    })
    if not hints_enabled then
      print("Inlay Hints & Diagnostics Text: ON")
    else
      print("Inlay Hints & Diagnostics Text: OFF")
    end
  end, { desc = "Toggle Inlay Hints & Error Text" })

  vim.g.rustaceanvim = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
          lru = {
            capacity = 512,
          },
        },
      },
    },
  }
end
