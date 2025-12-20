-- SOPS transparent editing for *.sops files
-- Requirements: sops in PATH. Key env configured (e.g. SOPS_AGE_KEY_FILE).
-- Behavior:
--   - Decrypt on read into buffer
--   - Encrypt on write WITHOUT replacing the buffer (undo preserved)
--   - Write failure safety: won't modify the on-disk file if sops fails

local aug = vim.api.nvim_create_augroup("SopsTransparentEdit", { clear = true })

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "sops" })
end

local function set_ft_from_name_without_sops(buf)
  local real = vim.api.nvim_buf_get_name(buf)
  local fake = real:gsub("%.sops$", "")
  local ft = vim.filetype.match({ filename = fake })
  if ft then
    vim.bo[buf].filetype = ft
  end
end

-- Read: replace buffer with decrypted content
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = aug,
  pattern = "*.sops",
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    if file == "" then
      return
    end

    -- Run: sops -d file
    local res = vim.system({ "sops", "-d", file }, { text = true }):wait()

    if res.code ~= 0 then
      notify(("decrypt failed for %s\n%s"):format(file, res.stderr or ""), vim.log.levels.ERROR)
      return
    end

    -- Load decrypted content into buffer (keeps undo working)
    local lines = vim.split(res.stdout or "", "\n", { plain = true })
    -- Drop final empty line if present (common with stdout)
    if #lines > 0 and lines[#lines] == "" then
      table.remove(lines, #lines)
    end

    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
    vim.bo[args.buf].modified = false
    vim.bo[args.buf].buftype = "" -- normal file buffer
    vim.bo[args.buf].swapfile = false
    vim.bo[args.buf].backup = false
    vim.bo[args.buf].writebackup = false

    -- Keep undo, but avoid persistent undo files writing plaintext to disk
    -- If you *want* persistent undo, see note below.
    vim.bo[args.buf].undofile = false

    set_ft_from_name_without_sops(args.buf)
  end,
})

-- Write: encrypt buffer content and write ciphertext to file atomically
vim.api.nvim_create_autocmd("BufWriteCmd", {
  group = aug,
  pattern = "*.sops",
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    if file == "" then
      notify("no filename set for buffer", vim.log.levels.ERROR)
      return
    end

    -- Get plaintext from buffer
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local plaintext = table.concat(lines, "\n") .. "\n"

    -- Encrypt via stdin, using the existing file as the target format/metadata reference
    -- Using: sops -e --input-type <auto> --output-type <auto> /dev/stdin
    -- But sops chooses type based on --filename-override (helps with *.env.sops etc.)
    local fake = file:gsub("%.sops$", "")
    local res = vim
      .system({ "sops", "-e", "--filename-override", fake, "/dev/stdin" }, { text = true, stdin = plaintext })
      :wait()

    if res.code ~= 0 then
      notify(("encrypt failed for %s\n%s"):format(file, res.stderr or ""), vim.log.levels.ERROR)
      return
    end

    -- Atomic write: write to temp then rename
    local dir = vim.fn.fnamemodify(file, ":h")
    local base = vim.fn.fnamemodify(file, ":t")
    local tmp = ("%s/.%s.%d.tmp"):format(dir, base, vim.fn.getpid())

    local ok, err = pcall(function()
      local fd = assert(io.open(tmp, "wb"))
      fd:write(res.stdout or "")
      fd:flush()
      fd:close()
      -- Rename is atomic on same filesystem
      assert(os.rename(tmp, file))
    end)

    if not ok then
      -- Best effort cleanup
      pcall(os.remove, tmp)
      notify(("write failed for %s\n%s"):format(file, err), vim.log.levels.ERROR)
      return
    end

    -- Mark buffer clean; keep plaintext in buffer
    vim.bo[args.buf].modified = false
    notify(("written (encrypted): %s"):format(file), vim.log.levels.INFO)
  end,
})
