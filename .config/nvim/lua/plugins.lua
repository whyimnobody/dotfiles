-- Bootstrap lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

local plugins = {
	-- Colour scheme
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "night",
		},
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",

		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-pack/nvim-spectre" },
		config = function()
			require("configs.telescope")
		end,
	},
	-- Neo Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		version = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		config = function()
			require("configs.neotree")
		end,
	},
	-- Tabs for buffers
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("configs.bufferline")
		end,
	},
	-- Status line
	{
		"windwp/windline.nvim",
		config = function()
			require("wlsample.bubble")
		end,
	},
	-- Undo tree for not losing your mind
	{ "mbbill/undotree" },
	-- Better buffer deleting, without fucking up the windows
	{ "famiu/bufdelete.nvim" },
	-- TODO: Unweave below into separate plugin defintions

	-- LSP and related
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			require("configs.lsp")
		end,
	}, -- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	}, -- CMP
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7eh/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("configs.cmp")
		end,
	},
	-- LSP UI improvements
	-- {
	--     "glepnir/lspsaga.nvim",
	--     event = "LspAttach",
	--     dependencies = {{"nvim-tree/nvim-web-devicons"}},
	--     config = function()
	--         require("lspsaga").setup({})
	--     end
	-- },
	-- Debugging
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
	}, -- Git tools
	{
		"pwntester/octo.nvim",
		event = "VeryLazy",
		requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end,
	}, -- Git Signs
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	}, -- Trouble
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{ "tpope/vim-surround" }, -- updating pairs of prose made simple, with ys, cs and ds
	{ "RRethy/vim-illuminate" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("configs.autopairs")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "mg979/vim-visual-multi" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},
	{ "szw/vim-maximizer" }, -- maximises and restores current pane, with <C-w>
	-- tmux navigation
	{ "christoomey/vim-tmux-navigator" }, -- Key Cheatsheet
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.whichkey")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{ "j-hui/fidget.nvim" },
	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("configs.neoscroll")
		end,
	}, -- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = false,
			},
			panel = {
				enabled = false,
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- Miscellaneous
	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
}

-- vim: tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=1

require("lazy").setup(plugins, opts)

-- MAYBES
-- https://github.com/jose-elias-alvarez/typescript.nvim
