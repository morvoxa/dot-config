return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- 1. Custom Formatter Definitions
      formatters = {
        ["dioxus"] = {
          cmd = { "dx", "fmt", "--file", "$FILENAME" },
        },
        ["clang-format"] = {
          prepend_args = { "--style=Google" },
        },
      },

      -- 2. Formatter per Language
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "gersemi" },
        h = { "clang-format" },
        lua = { "stylua" },
        rust = { "dioxus", "rustfmt" },
        toml = { "taplo" },
        nix = { "nixfmt" },

        -- Web Stack
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        markdown = { "prettier" },
      },

      -- 3. Setting Format On Save
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never",
      },
    },
  },
}
