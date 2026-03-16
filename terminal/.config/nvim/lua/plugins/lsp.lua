return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = false },
      servers = {
        ["*"] = {
          keys = {
            { "K", "5k", desc = "Up faster" },
          },
        },
        -- pyright = {
        --   settings = {
        --     python = {
        --       analysis = {
        --         diagnosticMode = "workspace",
        --       },
        --     },
        --   },
        -- },
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
