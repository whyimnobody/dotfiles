local opt = vim.opt
local cmd = vim.cmd

-- COMMANDS
-- Set associating between turned on plugins and filetype
cmd [[filetype plugin on]]
-- Disable comments on pressing Enter
cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- GENERAL
-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- cursorline
opt.cursorline = false

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")
opt.fixeol = true

-- folding
opt.foldmethod = "syntax"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.scrolloff = 8
opt.colorcolumn = "80"

-- PLUGINS
-- undotree
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Default Plugins
local disabled_built_ins = {"gzip", "zip", "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
                            "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit"}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
