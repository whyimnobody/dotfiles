-- Must run before LazyVim sets clipboard=unnamedplus. Otherwise Neovim
-- autoloads xclip because tmux still has a stale DISPLAY (currently :0,
-- compositor is :1) and no XAUTHORITY. Yank then fails with:
--   clipboard: error invoking xclip: Can't open display: :0
-- and never reaches copy-osc52.

if vim.env.DISPLAY and not vim.env.XAUTHORITY then
  vim.env.DISPLAY = nil
end

if not vim.env.TMUX then
  return
end

local copy_osc52 =
  [[tmux load-buffer - && tmux save-buffer - | "$HOME/.config/tmux/copy-osc52" "$TMUX_PANE"]]

vim.g.clipboard = {
  name = "tmux OSC 52",
  copy = {
    ["+"] = { "sh", "-c", copy_osc52 },
    ["*"] = { "sh", "-c", copy_osc52 },
  },
  paste = {
    ["+"] = { "tmux", "save-buffer", "-" },
    ["*"] = { "tmux", "save-buffer", "-" },
  },
  cache_enabled = 0,
}
vim.opt.clipboard = "unnamedplus"

vim.g.loaded_clipboard_provider = nil
vim.cmd.runtime("autoload/provider/clipboard.vim")
