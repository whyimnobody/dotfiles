vim.g.mapleader = " "

local keymap = vim.keymap

-- https://github.com/pazams/d-is-for-delete
-- GENERAL
keymap.set("n", "x", '"_x') -- delete without adding deleted character to buffer
keymap.set({ "n", "v" }, "d", '"_d') -- cut mode into the void
keymap.set("n", "D", '"_D') -- cut line into the void
keymap.set({ "n", "v" }, "<leader>d", '""d') -- cut to buffer
keymap.set("n", "<leader>D", '""D') -- cut to EOL to buffer
keymap.set("n", "<C-w>x", ":close<CR>") -- close current window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to the next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to the previous tab

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- PLUGIN KEYMAPS
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle a panes maximisation
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer visibility

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fi", "<cmd>Telescope git_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
