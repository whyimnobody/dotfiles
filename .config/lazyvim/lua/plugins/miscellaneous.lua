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
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  -- { "kristijanhusak/vim-dadbod-completion" },

  -- direnv
  { "direnv/direnv.vim" },

  -- Indentation detection
  { "Darazaki/indent-o-matic", config = true },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      -- table.insert(opts.sections.lualine_c, { require("auto-session.lib").current_session_name })
    end,
  },

  -- Markdown previewer
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

  -- Multicursor
  { "mg979/vim-visual-multi" },

  -- Navigation
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    config = true,
    keys = {
      { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
      { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
      { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
      { "<leader>ha", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
    },
  },

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["C"] = "close_all_subnodes",
          ["Z"] = "expand_all_nodes",
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            end
          end,
        },
      },
    },
  },

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

  -- Peek when navigating by line number
  { "nacro90/numb.nvim" },

  -- Smart columns
  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {},
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

  -- Templating
  { "glench/vim-jinja2-syntax" },

  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- Tmux Navigator
  { "christoomey/vim-tmux-navigator" },

  -- Undotree
  { "mbbill/undotree" },
}
