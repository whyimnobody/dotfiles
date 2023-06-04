require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            filetype = "neo-tree",
            text = function()
                return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left"
        }}
    }
})
