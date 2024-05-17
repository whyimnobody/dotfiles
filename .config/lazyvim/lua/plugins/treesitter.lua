return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "python",
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
    },
  },
  { "HiPhish/nvim-ts-rainbow2" },
  {
    "windwp/nvim-ts-autotag",
    config = {
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "astro",
        "glimmer",
        "handlebars",
        "hbs",
        "htmldjango",
        "jinja",
        "eruby",
      },
    },
  },
  { "IndianBoy42/tree-sitter-just" },
}
