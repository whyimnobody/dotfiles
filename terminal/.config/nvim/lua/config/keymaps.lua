-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://github.com/pazams/d-is-for-delete
-- GENERAL
vim.keymap.set("n", "x", '"_x', { desc = "Delete char into the void" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change char into the void" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "[D]elete mode into the void" })
vim.keymap.set("n", "D", '"_D', { desc = "[D]elete line into the void" })

-- Substitute
vim.keymap.set(
  { "n", "v" },
  "<leader>cs",
  '"zy:%s/<C-r>z//g<Left><Left>',
  { noremap = true, desc = "[S]ubstitute across buffer" }
)

-- Perusing code faster with K and J
vim.keymap.set({ "n", "v" }, "K", "5k", { noremap = true, desc = "Up faster" })
vim.keymap.set({ "n", "v" }, "J", "5j", { noremap = true, desc = "Down faster" })

-- Remap K and J
vim.keymap.set({ "n", "v" }, "<leader>k", "K", { noremap = true, desc = "Keyword" })
vim.keymap.set({ "n", "v" }, "<leader>j", "J", { noremap = true, desc = "Join lines" })
vim.keymap.set({ "n", "v" }, "gk", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Move lines
vim.keymap.set("n", "<A-j>", "<cmd>m +1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m -2<cr>==", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m +1<cr>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m -2<cr>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Duplicate Lines
vim.keymap.set("n", "<A-J>", "<cmd>t .<cr>==", { desc = "Duplicate down" })
vim.keymap.set("n", "<A-K>", "<cmd>t .-1<cr>==", { desc = "Duplicate up" })
vim.keymap.set("i", "<A-J>", "<esc><cmd>t .<cr>==gi", { desc = "Duplicate down" })
vim.keymap.set("i", "<A-K>", "<esc><cmd>t .-1<cr>==gi", { desc = "Duplicate up" })
vim.keymap.set("v", "<A-J>", ":t '><cr>gv=gv", { desc = "Duplicate down" })
vim.keymap.set("v", "<A-K>", ":t '<-1<cr>gv=gv", { desc = "Duplicate up" })

-- Bufferline
vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<cr>", { desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<cr>", { desc = "Move buffer right" })
vim.keymap.set(
  "n",
  "<leader>b0",
  ":lua require'bufferline'.move_to(1)<cr>",
  { desc = "Move buffer line to first position" }
)
vim.keymap.set(
  "n",
  "<leader>b$",
  ":lua require'bufferline'.move_to(-1)<cr>",
  { desc = "Move buffer line to last position" }
)

-- flash.nvim
vim.keymap.set({ "n" }, "<leader>fl", "<cmd>lua require('flash').flash()<cr>", { desc = "Toggle flash.nvim" })

-- Oil
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "[O]pen parent directory" })

-- Silicon (sexy screenshots)
vim.keymap.set({ "n", "v" }, "<leader>cx", ":Silicon<cr>", { desc = "[S]napshot [C]ode" })

-- tmux navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate right" })

-- Undotree
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "[U]ndotree" })

-- Whichkey group registrations
local wk = require("which-key")
wk.add({})
