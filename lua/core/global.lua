-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🌍 Neovim Global Variables Configuration                                     │
-- │                                                                              │
-- │ 📜 Purpose:                                                                  │
-- │ Define global settings like OS detection, important paths, and shared values.│
-- │                                                                              │
-- │ 🛠️ Includes:                                                                 │
-- │   - OS detection flags                                                       │
-- │   - Standard paths (config, cache, modules, data)                            │
-- │   - Shared UI values (e.g., sidebar width)                                   │
-- │   - Session directory setup (ensures ~/.cache/nvim/sessions exists)          │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

local global = {}

-- 🌐 Detect OS
local os_name = vim.loop.os_uname().sysname
global.is_mac = os_name == "Darwin"
global.is_linux = os_name == "Linux"
global.is_windows = os_name == "Windows"

-- 🗂️ Define important paths
global.vim_path = vim.fn.stdpath "config"
local path_sep = global.is_windows and "\\" or "/"
local home = global.is_windows and os.getenv "USERPROFILE" or os.getenv "HOME"
global.home = home
global.cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep
global.modules_dir = global.vim_path .. path_sep .. "modules"
global.data_dir = string.format("%s/site/", vim.fn.stdpath "data")

-- 📏 Shared Sidebar Width (global)
vim.g.shared_sidebar_width = math.floor(vim.o.columns * 0.2)

-- 🔄 Auto-update shared width on resize (uncomment if needed)
-- vim.api.nvim_create_autocmd("VimResized", {
--   callback = function()
--     vim.g.shared_sidebar_width = math.floor(vim.o.columns * 0.2)
--   end,
-- })

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 💾 Session Directory Setup                                                   │
-- │ Ensures that ~/.cache/nvim/sessions exists for session management.           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local session_dir = global.cache_dir .. "sessions"
if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, "p")
  vim.notify("💾 Created session directory at: " .. session_dir, vim.log.levels.INFO, { title = "Session Setup" })
end

return global
