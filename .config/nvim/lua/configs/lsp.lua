local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
local lspconfig = require("lspconfig")

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls", -- LSP for Lua language
		"tsserver", -- LSP for Typescript and Javascript
		"rust_analyzer", -- LSP for Rust
		"emmet_ls", -- LSP for Emmet (Vue, HTML, CSS)
		"tailwindcss", -- LSP for Tailwind
		"cssls", -- LSP for CSS
		"stylelint_lsp", -- Linter for CSS, Sass, Less
		"dockerls", -- LSP for Docker
		"pyright", -- LSP for Python
	},
	automatic_installation = true,
})

-- Setup every needed language server in lspconfig
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,
})
-- additional lspconfig
local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = hl,
	})
end

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

-- LSP Config
require("configs.lsp_config")

-- Formatting
require("configs.nullls")

-- Debugging
require("mason-nvim-dap").setup()
require("nvim-dap-virtual-text").setup()
