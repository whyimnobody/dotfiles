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

-- oil toggle file detail view
local oil_detail = false
local function toggle_oil_detail()
  oil_detail = not oil_detail
  if oil_detail then
    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
  else
    require("oil").set_columns({ "icon" })
  end
end

-- Set the keymap only for Oil buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "gd", toggle_oil_detail, { desc = "Toggle file detail view", buffer = true })
  end,
})

-- Define a Lua function to turn an env into envrc
local function env_to_envrc()
  vim.cmd([[silent! %norm Iexport ]])
  vim.cmd([[silent! %s/export \n/\r/g]])
  vim.cmd([[silent! %s/export #/#/g]])
end

-- Create a user command :EnvToEnvrc
vim.api.nvim_create_user_command("EnvToEnvrc", env_to_envrc, {})
