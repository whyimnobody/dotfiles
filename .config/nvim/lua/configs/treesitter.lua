require'nvim-treesitter.configs'.setup {

    -- Needed parsers
    ensure_installed = {"c", "elixir", "javascript", "lua", "python", "typescript", "rust"},

    -- Install all parsers synchronously
    sync_install = false,

    -- Подсветка
    highlight = {
        -- Enabling highlight for all files
        enable = true,
        disable = {}
    },

    indent = {
        -- Disabling indentation for all files
        enable = false,
        disable = {}
    }
}
