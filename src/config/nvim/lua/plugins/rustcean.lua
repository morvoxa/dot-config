return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "check",
          },
        },
      },
    },
  },
}
