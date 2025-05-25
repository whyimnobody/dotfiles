-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80,88,120"

-- Set the fold method to indentation instead of expr
-- https://vimhelp.org/fold.txt.html#fold-methods
vim.opt.foldmethod = "indent"

vim.filetype.add({
  extension = {
    postcss = "postcss",
    pcss = "css",
  },
})

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
