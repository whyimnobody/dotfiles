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

-- Auto-watcher for .nvim config changes
local function setup_nvim_config_watcher()
  local nvim_dir = vim.fn.getcwd() .. "/.nvim"

  -- Only set up watcher if .nvim directory exists
  if vim.fn.isdirectory(nvim_dir) == 0 then
    return
  end

  local group = vim.api.nvim_create_augroup("NvimConfigWatcher", { clear = true })

  -- Watch for file changes in .nvim directory
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = group,
    pattern = vim.fn.getcwd() .. "/.nvim/*.lua",
    callback = function()
      vim.notify("Reloading .nvim configs...", vim.log.levels.INFO)
      load_local_nvim_configs()
      vim.notify("✓ .nvim configs reloaded", vim.log.levels.INFO)
    end,
    desc = "Auto-reload .nvim configs when saved",
  })

  -- Re-setup watcher when changing directories
  vim.api.nvim_create_autocmd({ "DirChanged" }, {
    group = group,
    callback = function()
      vim.schedule(function()
        setup_nvim_config_watcher()
      end)
    end,
    desc = "Setup .nvim config watcher for new directories",
  })
end

-- Enable watcher by default
setup_nvim_config_watcher()

-- Functions to make using DAP and adding custom files easier
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

local function write_file(path, content)
  local file = io.open(path, "w")
  if file then
    file:write(content)
    file:close()
  end
end

local function append_file(path, content)
  local file = io.open(path, "a")
  if file then
    file:write(content)
    file:close()
  end
end

-- === 1. Create .nvim/ruff.lua for Conform ===
local function scaffold_ruff()
  ensure_dir(".nvim")
  local ruff_path = ".nvim/ruff.lua"

  if vim.fn.filereadable(ruff_path) == 1 then
    print("ruff.lua already exists")
    return
  end

  local content = [[
local ok, conform = pcall(require, "conform")
if not ok then return end

conform.setup({
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format" },
  },
  formatters = {
    ruff_fix = {
      command = "ruff",
      args = { "check", "--fix", "--ignore", "E501", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    },
  },
})
]]
  write_file(ruff_path, content)
  print("Created .nvim/ruff.lua")
end

-- === 2. Append DAP Config ===
local function scaffold_dap(app_type)
  ensure_dir(".nvim")
  local dap_path = ".nvim/dap.lua"

  local dap_configs = {
    django = [[
      table.insert(dap.configurations.python, {
        name = "Django Dev Server",
        type = "python",
        request = "launch",
        program = "${workspaceFolder}/manage.py",
        args = { "runserver", "0.0.0.0:8000" },
        justMyCode = false,
    })]],
    fastapi = [[
      table.insert(dap.configurations.python, {
        name = "FastAPI (uvicorn)",
        type = "python",
        request = "launch",
        module = "uvicorn",
        args = { "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000" },
        justMyCode = false,
      })]],
    go = [[
      table.insert(dap.configurations.go, {
        type = "go",
        name = "Debug main.go",
        request = "launch",
        program = "${file}",
      })]],
    laravel = [[
      table.insert(dap.configurations.php, {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}"
        }
      })]],
    typescript = [[
      table.insert(dap.configurations.typescript, {
        type = "pwa-node",
        request = "launch",
        name = "Debug TypeScript File",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
        runtimeArgs = { "--loader", "ts-node/esm" },
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**" },
      })]],
    javascript = [[
      table.insert(dap.configurations.javascript, {
        type = "pwa-node",
        request = "launch",
        name = "Debug JavaScript File",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**" },
      })]],
    react = [[
      table.insert(dap.configurations.javascript, {
        type = "pwa-chrome",
        name = "Attach to React (Vite or CRA)",
        request = "launch",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}/src",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**" },
      })]],
    vue = [[
      table.insert(dap.configurations.javascript, {
        type = "pwa-chrome",
        name = "Attach to Vue (Vite or Vue CLI)",
        request = "launch",
        url = "http://localhost:5173",
        webRoot = "${workspaceFolder}/src",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**" },
      })]],
    pytest = [[
      table.insert(dap.configurations.python, {
        name = "Debug Pytest",
        type = "python",
        request = "launch",
        module = "pytest",
        args = {},
        justMyCode = false,
        console = "integratedTerminal",
      })]],
    vitest = [[
      table.insert(dap.configurations.javascript, {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vitest",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/vitest/vitest.mjs",
          "run",
          "--inspect-brk",
          "--threads=false", -- required for DAP to attach cleanly
        },
        skipFiles = { "<node_internals>/**" },
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      })]],
    jest = [[
      table.insert(dap.configurations.javascript, {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        skipFiles = { "<node_internals>/**" },
      })]],
  }

  local content = dap_configs[app_type]
  if not content then
    print("Unsupported app type: " .. app_type)
    return
  end

  -- Add base adapter section if new file
  if vim.fn.filereadable(dap_path) == 0 then
    local base = [[
local dap = require("dap")

dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  }
}

dap.adapters["pwa-chrome"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  }
}

dap.adapters.go = {
  type = "executable",
  command = "dlv",
  args = { "dap", "-l", "127.0.0.1:${port}" },
}

dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
}

dap.configurations = dap.configurations or {}
dap.configurations.python = dap.configurations.python or {}
dap.configurations.javascript = dap.configurations.javascript or {}
dap.configurations.typescript = dap.configurations.typescript or {}
dap.configurations.go = dap.configurations.go or {}
dap.configurations.php = dap.configurations.php or {}
]]
    write_file(dap_path, base .. "\n" .. content .. "\n")
    print("Created dap.lua with " .. app_type .. " config")
  else
    append_file(dap_path, "\n" .. content .. "\n")
    print("Appended " .. app_type .. " config to dap.lua")
  end
end

-- Load user commands
require("util.commands")

return {
  scaffold_ruff = scaffold_ruff,
  scaffold_dap = scaffold_dap,
  reload_local_configs = load_local_nvim_configs,
  setup_watcher = setup_nvim_config_watcher,
}
