vim.opt.exrc = true
vim.opt.secure = true

local workspace_path = vim.fn.getcwd()
local data_dir = vim.fn.stdpath("data")
local project_dir = data_dir .. "/shada/"

if vim.fn.isdirectory(project_dir) == 0 then
  vim.fn.mkdir(project_dir, "p")
end

local shadafile = project_dir .. "/" .. vim.fn.sha256(workspace_path):sub(1, 32) .. ".shada"
vim.opt.shadafile = shadafile
