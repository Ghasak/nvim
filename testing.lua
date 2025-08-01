-- LSP Diagnostic Script
-- Save this as a separate file and run with :luafile path/to/this/file.lua
-- Or copy-paste into Neovim command line with :lua

local function check_lsp_status()
  print("=== LSP Diagnostic Information ===")
  print("Neovim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)
  print("")

  -- Check active LSP clients
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("❌ No active LSP clients found")
    return
  end

  print("✅ Active LSP clients:")
  for _, client in ipairs(clients) do
    print("  - " .. client.name .. " (ID: " .. client.id .. ")")
  end
  print("")

  -- Check current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #buf_clients == 0 then
    print("❌ No LSP clients attached to current buffer")
    print("   Buffer filetype: " .. vim.bo.filetype)
    print("   Try opening a file with a supported filetype (lua, python, rust, etc.)")
    return
  end

  print("✅ LSP clients attached to current buffer:")
  for _, client in ipairs(buf_clients) do
    print("  - " .. client.name)
  end
  print("")

  -- Check key mappings
  print("🔍 Checking LSP key mappings in current buffer:")
  local mappings_to_check = {
    { "n", "gh", "LSP Hover" },
    { "n", "gI", "Go to Implementation" },
    { "n", "<leader>gr", "References" },
    { "n", "gl", "Diagnostic Float" },
    { "n", "<leader>la", "Code Action" },
    { "n", "<leader>lr", "Rename" },
  }

  for _, mapping in ipairs(mappings_to_check) do
    local mode, lhs, desc = mapping[1], mapping[2], mapping[3]
    local maps = vim.api.nvim_buf_get_keymap(bufnr, mode)
    local found = false

    for _, map in ipairs(maps) do
      if map.lhs == lhs then
        print("  ✅ " .. lhs .. " → " .. desc)
        found = true
        break
      end
    end

    if not found then
      print("  ❌ " .. lhs .. " → " .. desc .. " (NOT FOUND)")
    end
  end

  print("")
  print("🔧 Manual test: Try pressing 'gh' in normal mode while cursor is on a symbol")
  print("   If hover doesn't work, the keymap setup failed")
end

-- Run the diagnostic
check_lsp_status()
