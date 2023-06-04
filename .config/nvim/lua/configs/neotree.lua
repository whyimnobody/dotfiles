--[[
  File: nvimtree.lua
  Description: Neovim Tree plugin configuration (with lspconfig)
  See: https://github.com/nvim-tree/nvim-tree.lua
]] local neotree = require("neo-tree")

neotree.setup({
    filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_by_name = {
                -- "node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                -- "*.meta",
                -- "*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                -- ".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                -- ".DS_Store",
                -- "thumbs.db"
            }
        }
    },
    window = {
        mappings = {
            ["<space>"] = "none"
        }
    },
    default_component_configs = {
        indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander"
        }
    }
})

