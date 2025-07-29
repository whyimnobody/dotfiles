return {
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  { "kaymmm/bullets.nvim" },

  -- Cloak secrets and config
  { "laytan/cloak.nvim", config = true },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    flavour = "mocha",
    opts = {
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  -- Database Stuff
  -- { "tpope/vim-dadbod" },
  -- { "kristijanhusak/vim-dadbod-ui" },
  -- -- { "kristijanhusak/vim-dadbod-completion" },

  -- direnv
  { "direnv/direnv.vim" },

  -- Indentation detection
  { "Darazaki/indent-o-matic", config = true },

  -- -- justfile syntax highlighting
  { "NoahTheDuke/vim-just" },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
    end,
  },

  -- Multicursor
  { "mg979/vim-visual-multi" },

  -- Noice customisation
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  -- oil.nvim
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = false, -- Show files and directories that start with "."
      },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  },

  -- Peek when navigating by line number
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  -- Rainbow CSV (in vimscript)
  { "mechatroner/rainbow_csv" },

  -- Smart columns
  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {
      colorcolumn = "100",
    },
  },

  -- Snacks
  {
    "folke/snacks.nvim",
    opts = {
      -- dashboard = {
      --   sections = {
      --     {
      --       section = "terminal",
      --       cmd = "chafa ~/.config/nvim/banner.jpg; sleep .1",
      --       height = 17,
      --       padding = 1,
      --     },
      --     { section = "keys", gap = 1, padding = 1 },
      --     { section = "startup" },
      --   },
      -- },
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = {
            show_empty = true,
            hidden = true,
            ignored = true,
          },
        },
        formatters = {
          file = {
            truncate = 80,
          },
        },
      },
    },
  },

  -- Snapshots
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("silicon").setup({
        font = "CommitMono Nerd Font=34",
        theme = "Catppuccin Mocha",
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end,
        output = function()
          return os.getenv("HOME") .. "/Downloads/Screenshots/Snapshot " .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
        end,
      })
    end,
  },

  -- Tabs (and buffers [and scope of them])
  { "tiagovla/scope.nvim", config = true },

  -- Templating
  { "glench/vim-jinja2-syntax" },

  -- Tmux Navigator
  { "christoomey/vim-tmux-navigator" },

  {
    "folke/which-key.nvim",
    -- opts will be merged with the parent spec
    opts = { preset = "modern" },
  },
}
