-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80,88,120"

-- Set the fold method to indentation instead of expr
-- https://vimhelp.org/fold.txt.html#fold-methods
vim.opt.foldmethod = "indent"

vim.filetype.add({
  extension = {
    postcss = "postcss",
    pcss = "css",
  },
})

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.

vim.g.lazyvim_picker = "snacks"

-- Allow loading of local lua files in nvim
-- Primarily for DAP and maybe testing stuff
-- Hoping I can customise Ruff and other aggressive linters and checkers
local function load_local_nvim_configs()
  local Path = vim.fn.getcwd() .. "/.nvim"
  local files = vim.fn.glob(Path .. "/*.lua", false, true)

  for _, file in ipairs(files) do
    local ok, err = pcall(dofile, file)
    if not ok then
      vim.notify("Failed to load " .. file .. ": " .. err, vim.log.levels.ERROR)
    end
  end
end

load_local_nvim_configs()
