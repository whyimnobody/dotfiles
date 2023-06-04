vim.g.mapleader = " " -- Use Space, like key for alternative hotkeys

local keymap = vim.keymap

-- https://github.com/pazams/d-is-for-delete
-- GENERAL
keymap.set("n", "x", '"_x', { desc = "Delete char into the void" })
keymap.set({ "n", "v" }, "d", '"_d', { desc = "[D]elete mode into the void" })
keymap.set("n", "D", '"_D', { desc = "[D]elete line into the void" })
keymap.set({ "n", "v" }, "<leader>d", '""d', { desc = "[D]elete to buffer" })
keymap.set("n", "<leader>D", '""D', { desc = "Cut to EOL to buffer" })
keymap.set("n", "<C-w>x", ":close<CR>", { desc = "[W]indow [Cl]ose" })

-- keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to the next tab
-- keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to the previous tab

-- keymap.set("n", "<leader>bo", ":<CR>") -- open a new tab
keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "[B]uffer [D]elete" })
keymap.set("n", "<leader>bd", ":BWipeout<CR>", { desc = "[B]uffer [W]ipeout" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "[B]uffer [Next]" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "[B]uffer [P]revious" })

keymap.set("n", "A-j", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "A-k", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("i", "A-j", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap.set("i", "A-k", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap.set("v", "A-j", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "A-k", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- keymap.set({ "n", "i", "v" }, "A-J", "yy>+1p", { desc = "Duplicate line down" })
-- keymap.set({ "n", "i", "v" }, "A-K", "yy<-2p", { desc = "Duplicate line up" })

-- PLUGINS
-- LSP
keymap.set("n", "<leader>cA", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover over [c]ode [a]ction" })
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "[C]ode [A]ction" })
keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "[C]ode object [R]ename" })
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "[R]estart L[S]P" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope [F]ind [F]iles" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope [F]ile [G]rep" })
keymap.set("n", "<leader>fi", "<cmd>Telescope git_files<cr>", { desc = "Telescope [F]ind [I]n git" })
keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Telescope [F]ind [S]tring search" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope [F]ind in current [B]uffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope [F]ind [H]elp" })

-- Spectre
keymap.set("n", "<leader>fr", function()
	require("spectre").open()
end, {
	desc = "In [F]ile [R]eplace with Spectre",
})

-- Git
keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "[G]it [P]review hunk" })
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "[G]it [B]lame line" })
-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "[G]it [C]ommits" })
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>", { desc = "[G]it [F]ile [C]ommits" })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "[G]it [B]rances" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "[G]it [S]tatus" })

-- Trouble
keymap.set("n", "<leader>x", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" }) -- Show all problems in project (with help of LSP)
keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", { desc = "[G]oto [R]eferences" }) -- Show use of object in project

-- NeoTree
keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({
		toggle = true,
	})
end, { desc = "[E]xplorer" })
keymap.set("n", "<leader>E", function()
	require("neo-tree.command").execute({
		toggle = true,
		dir = vim.loop.cwd(),
	})
end)

-- Undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndotree" })

-- ToggleTerm
-- keymap.set("n", "<leader>tt",)

-- vim: tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=1 foldlevel=1
