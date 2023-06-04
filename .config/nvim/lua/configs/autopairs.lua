-- import nvim-autopairs safely
local autopairs = require("nvim-autopairs")
local autopairs_cmp = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

-- configure autopairs
autopairs.setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
		java = false, -- don't check treesitter on java
	},
})

-- make autopairs and completion work together
cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done())
