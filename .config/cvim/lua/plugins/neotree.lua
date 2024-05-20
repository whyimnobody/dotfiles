return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' and node:is_expanded() then
            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
          else
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
            elseif node:has_children() then
              require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
  config = function(_, opts)
    opts.event_handlers = opts.event_handlers or {}

    local function on_move(data)
      local clients = vim.lsp.get_active_clients()
      for _, client in ipairs(clients) do
        if client:supports_method("workspace/willRenameFiles") then
          local resp = client.request_sync("workspace/willRenameFiles", {
            files = { { oldUri = vim.uri_from_fname(data.source), newUri = vim.uri_from_fname(data.destination) } },
          }, 1000)
          if resp and resp.result ~= nil then
            vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
          end
        end
      end
    end

    local events = require("neo-tree.events")
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED,   handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}
