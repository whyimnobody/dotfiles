return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", "5k", desc = "Up faster" },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
      },
      formatters = {
        djlint = {
          timeout_ms = 5000, -- Increase this value if you experience timeouts
        },
      },
    },
  },
}
