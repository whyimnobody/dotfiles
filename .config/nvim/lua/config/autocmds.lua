-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Change directory to working directory
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("lazyvim_custom_cd_pwd", { clear = true }),
  command = "if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif",
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel because ew
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    -- vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})
-- Set Markdown word wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "md" },
  command = "setlocal wrap",
})
