-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Change directory to working directory
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("lazyvim_custom_cd_pwd", { clear = true }),
  command = "if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif",
})
