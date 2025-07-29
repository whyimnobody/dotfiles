-- Define a Lua function to turn an env into envrc
local function env_to_envrc()
  vim.cmd([[silent! %norm Iexport ]])
  vim.cmd([[silent! %s/export \n/\r/g]])
  vim.cmd([[silent! %s/export #/#/g]])
end

-- Create a user command :EnvToEnvrc
vim.api.nvim_create_user_command("EnvToEnvrc", env_to_envrc, {})

vim.api.nvim_create_user_command("ScaffoldRuff", function()
  require("util.functions").scaffold_ruff()
end, {})

vim.api.nvim_create_user_command("ScaffoldDap", function(opts)
  require("util.functions").scaffold_dap(opts.args)
end, {
  nargs = 1,
  complete = function()
    return {
      "django",
      "fastapi",
      "go",
      "javascript",
      "jest",
      "laravel",
      "pytest",
      "react",
      "typescript",
      "vitest",
      "vue",
    }
  end,
})

vim.api.nvim_create_user_command("ReloadNvimConfig", function()
  require("util.functions").reload_local_configs()
end, {})

-- Disable auto-reloading watcher
vim.api.nvim_create_user_command("DisableNvimWatcher", function()
  pcall(vim.api.nvim_del_augroup_by_name, "NvimConfigWatcher")
  vim.notify("✓ .nvim config auto-watcher disabled", vim.log.levels.INFO)
end, {})

-- Re-enable auto-reloading watcher
vim.api.nvim_create_user_command("EnableNvimWatcher", function()
  require("util.functions").setup_watcher()
  vim.notify("✓ .nvim config auto-watcher enabled", vim.log.levels.INFO)
end, {})

