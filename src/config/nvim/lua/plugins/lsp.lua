return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LSP Standar
        clangd = {},
        lua_ls = {},
        tailwindcss = {},
        vtsls = {},
        eslint = {},
        emmet_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        yamlls = {},
        nixd = {
          cmd = { "devenv", "lsp" },
        },
      },
    },
  },
}
