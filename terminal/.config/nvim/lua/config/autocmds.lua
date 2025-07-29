-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Load custom utility functions and commands
require("util.functions")

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

-- Numberline toggle - src: https://github.com/sitiom/nvim-numbertoggle
local numbertoggle_group = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = numbertoggle_group,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = numbertoggle_group,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
        vim.cmd("redraw")
      end
    end
  end,
})
