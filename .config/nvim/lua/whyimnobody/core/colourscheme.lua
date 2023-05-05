local status, _ = pcall(vim.cmd, "colorscheme onedark_dark")
if not status then
  print("Colourscheme not found!")
  return
end

