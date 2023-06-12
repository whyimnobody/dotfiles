-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- https://github.com/pazams/d-is-for-delete
-- GENERAL
vim.keymap.set("n", "x", '"_x', { desc = "Delete char into the void" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "[D]elete mode into the void" })
vim.keymap.set("n", "D", '"_D', { desc = "[D]elete line into the void" })
vim.keymap.set({ "n", "v" }, "<leader>d", '""d', { desc = "[D]elete to buffer" })
vim.keymap.set("n", "<leader>D", '""D', { desc = "Cut to EOL to buffer" })

-- Perusing code faster with K and J
vim.keymap.set({ "n", "v" }, "K", "5k", { noremap = true, desc = "Up faster" })
vim.keymap.set({ "n", "v" }, "<S-k>", "5k", { noremap = true, desc = "Up faster" })
vim.keymap.set({ "n", "v" }, "J", "5j", { noremap = true, desc = "Down faster" })

-- Remap K and J
vim.keymap.set({ "n", "v" }, "<leader>k", "K", { noremap = true, desc = "Keyword" })
vim.keymap.set({ "n", "v" }, "<leader>j", "J", { noremap = true, desc = "Join lines" })

-- Undotree
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "[U]ndotree" })
