-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80,88,120"

vim.filetype.add({
  extension = {
    postcss = "postcss",
    pcss = "css",
  },
})
