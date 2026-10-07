-- --------------------------------------------------------------------
--             ██╗     ██╗   ██╗ █████╗ ██╗     ██╗███╗  ██╗███████╗
--             ██║     ██║   ██║██╔══██╗██║     ██║████╗ ██║██╔════╝
--             ██║     ██║   ██║███████║██║     ██║██╔██╗██║█████╗
--             ██║     ██║   ██║██╔══██║██║     ██║██║╚████║██╔══╝
--             ███████╗╚██████╔╝██║  ██║███████╗██║██║ ╚███║███████╗
--             ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚══╝╚══════╝
--
--              █████╗  █████╗ ███╗  ██╗███████╗██╗ ██████╗
--             ██╔══██╗██╔══██╗████╗ ██║██╔════╝██║██╔════╝
--             ██║  ╚═╝██║  ██║██╔██╗██║█████╗  ██║██║  ██╗
--             ██║  ██╗██║  ██║██║╚████║██╔══╝  ██║██║  ╚██╗
--             ╚█████╔╝╚█████╔╝██║ ╚███║██║     ██║╚██████╔╝
--              ╚════╝  ╚════╝ ╚═╝  ╚══╝╚═╝     ╚═╝ ╚═════╝
-- --------------------------------------------------------------------
--
-- =================  Help can be found here  ==========================
-- :h statusline
-- =================  LSP language server client =======================
local M = {}

-- --------------------------------------------------------------------
--                       Full path function
-- --------------------------------------------------------------------
local full_path = function()
  -- Full path is with (F), short path is (f)
  return "%<%F%m %#__accent_red#%#__restore__#"
end
-- =================  LSP language server client =======================
-- 📦 Simplified environment cleaner: Extract last segment of VIRTUAL_ENV path
local function env_cleanup(venv) return venv and vim.fn.fnamemodify(venv, ":t") or "" end

-- 🛠️ LSP Status Function (for statusline)
local lsp_func = function()
  local server_icon = "󰒍"
  local server_icon_unknown = "󰒎"
  local buff_ft = vim.bo.filetype or ""
  local clients = vim.lsp.get_clients()
  -- 🌀 Get LSP spinner from lsp-progress
  local spinner = ""
  local status = require("lsp-progress").progress()
  if status and status ~= "" then
    spinner = status:match "LSP%s+([%z\1-\127\194-\244][\128-\191]*)" or ""
    spinner = vim.trim(spinner)
  end

  -- 🔴 No LSP clients attached
  if vim.tbl_isempty(clients) then
    return string.format("%s : %s-lsp*", server_icon_unknown, buff_ft ~= "" and buff_ft or "unknown")
  end

  -- 📋 Define known LSP mappings (for clarity)
  local lsp_map = {
    lua = { "lua_ls", "lua" },
    python = { "pyright", "pylsp" },
    r = { "r_language_server" },
    markdown = { "ltex" },
    typescript = { "tsserver" },
    javascript = { "tsserver" },
    julia = { "julials" },
    cpp = { "clangd" },
    rust = { "rust_analyzer" },
    tex = { "texlab", "ltex" },
  }

  -- 🔍 Iterate over active clients
  for _, client in ipairs(clients) do
    local valid_names = lsp_map[buff_ft]
    if valid_names and vim.tbl_contains(valid_names, client.name) then
      if buff_ft == "python" then
        local venv = os.getenv "VIRTUAL_ENV"
        return venv and string.format("%s %s-%s: pyright-lsp", spinner, server_icon, vim.fn.fnamemodify(venv, ":t"))
          or string.format("%s %s: pyright-lsp", spinner, server_icon)
      else
        return string.format("%s %s : %s-lsp", spinner, server_icon, buff_ft)
      end
    end
  end

  -- 🟡 Fallback for unknown clients
  return string.format("%s %s : %s-lsp*: %s", spinner, server_icon_unknown, buff_ft, clients[1].name or "unknown")
end
-- --------------------------------------------------------------------
--              CMAKE TOOLS FORM cmake-tools
--       https://github.com/Civitasv/cmake-tools.nvim
--       /blob/master/docs/howto.md
-- --------------------------------------------------------------------

-- local status_cmake_tools_ok, cmake = pcall(require, "cmake-tools")
-- if not status_cmake_tools_ok then
--   return M
-- end
--local icons = require "plugins.configs.icons"
-- --------------------------------------------------------------------
--                      Operating System Icon
-- --------------------------------------------------------------------
local system_icon = function()
  local system_type = vim.loop.os_uname().sysname
  local icon = ""
  if system_type == "Darwin" then
    icon = [["   "]]
  elseif system_type == "Linux" then
    icon = [["   "]]
  elseif system_type == "Windows" then
    icon = [[" 者 "]]
  else
    return ""
  end
  return icon
end

-- --------------------------------------------------------------------
--                     File Size Measure
-- --------------------------------------------------------------------
local vim = vim
local space = " "

local function file_size(file)
  local size = vim.fn.getfsize(file)
  if size == 0 or size == -1 or size == -2 then return "" end
  if size < 1024 then
    ---@diagnostic disable-next-line: cast-local-type
    size = tostring(size)
    ---@diagnostic disable-next-line: cast-local-type
    size = string.format("󰖡 %d", size) .. "B"
  elseif size < 1024 * 1024 then
    ---@diagnostic disable-next-line: cast-local-type
    size = string.format("󰖡 %d", math.floor(size / 1024)) .. "KB"
    ---@diagnostic disable-next-line: cast-local-type
  elseif size < 1024 * 1024 * 1024 then
    ---@diagnostic disable-next-line: cast-local-type
    size = string.format("󰖡 %d", math.floor(size / 1024 / 1024)) .. "MB"
  else
    ---@diagnostic disable-next-line: cast-local-type
    size = string.format("󰖡 %d", math.floor(size / 1024 / 1024 / 1024)) .. "GB"
  end
  return size .. space
end

local function get_file_size()
  local file = vim.fn.expand "%:p"
  if string.len(file) == 0 then return "" end
  return vim.trim(file_size(file))
end

-- --------------------------------------------------------------------
--                     HSP-Progress
--                  Work Space Loading time
-- --------------------------------------------------------------------
local function format_messages(messages)
  local result = {}
  local spinners = {
    "⣾",
    "⣽",
    "⣻",
    "⢿",
    "⡿",
    "⣟",
    "⣯",
    "⣷",
  }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 80) % #spinners
  local i = 1
  for _, msg in ipairs(messages) do
    if i < 3 then
      table.insert(result, (msg.percentage or 0) .. "%% " .. (msg.title or "Loading"))
      i = i + 1
    end
  end
  if #result == 0 then return spinners[frame + 1] .. " LSP Working" end
  return table.concat(result, " ") .. " " .. spinners[frame + 1]
end

local function hsp_progress()
  local messages = vim.lsp.status()
  local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
  if #clients == 0 then return "LSP: Off" end
  if #messages == 0 then
    -- Show spinner if any LSP client is initializing
    for _, client in ipairs(clients) do
      if client.initialized == false or client.server_capabilities == nil then
        local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 80) % #spinners
        return spinners[frame + 1] .. " LSP Initializing"
      end
    end
    return "LSP: Idle"
  end
  return format_messages(messages)
end -- --------------------------------------------------------------------
--                    Copilot status
-- --------------------------------------------------------------------
-- local function copilot_status()
--   local copilot_icon_loaded = "  󰚩 "
--   local copilot_icon_not_loaded = "  󰚩 "
--
--   if vim.fn.exists "g:copilot_enabled" == 1 then
--     if vim.inspect(vim.api.nvim_get_var "copilot_enabled") == "true" then
--       -- return true if copilot is installed and set to be enabled
--       return string.format("%s", copilot_icon_loaded)
--     else
--       return string.format("%s", copilot_icon_not_loaded)
--     end
--   else
--     return string.format("%s", copilot_icon_not_loaded)
--   end
-- end

-- 3) your statusline function reads that flag
local function copilot_status()
  local icon_on = "  󰚩"
  local icon_off = "  󰚩"
  return vim.g.copilot_enabled and icon_on or icon_off
end

-- --------------------------------------------------------------------
--                   LSP Progress Icon
-- --------------------------------------------------------------------

local function format_messages_2(messages)
  local result = {}
  -- local spinners = {"", " "}
  --- More Spinners: https://github.com/j-hui/fidget.nvim/blob/main/lua/fidget/spinners.lua
  local spinners = {
    -- "∙∙∙",
    -- "●∙∙",
    -- "∙●∙",
    -- "∙∙●",
    "∙∙∙",
    " ∙",
    "∙∙",
    "∙∙",
    "∙∙∙",
    -- "∙  ∙  ∙", "  ∙  ∙", "∙    ∙", "∙  ∙  ",
    -- "∙  ∙  ∙",
    -- "     ", "     ", "     ", "     ",
    -- "     "
    -- ""
    -- "",
    -- "", "", "󰪥", "󰪥", ""
    -- "󰪟",
    -- "󰪠",
    -- "󰪡",
    -- "󰪢",
    -- "󰪣",
    -- "󰪤",
    -- "",
    -- "ﱣ"
    -- "", "", "", "", "", "",
    --
    -- "⠋",
    -- "⠙",
    -- "⠹",
    -- "⠸",
    -- "⠼",
    -- "⠴",
    -- "⠦",
    -- "⠧",
    -- "⠇",
    -- "⠏",
    -- "∙∙∙∙",
    -- " ∙∙",
    -- "∙ ∙",
    -- "∙∙ ",
    -- "∙∙∙∙",
  }
  local ms = vim.loop.hrtime() / 1000000
  -- local frame    = math.floor(ms / 120) % #spinners
  local frame = math.floor(ms / 90) % #spinners
  -- local frame    = math.floor(ms / 160) % #spinners
  local i = 1
  -- Only display at most 2 progress messages at a time to avoid clutter
  for _, msg in pairs(messages) do
    if i < 3 then
      table.insert(result, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
      i = i + 1
    end
  end
  -- return table.concat(result, " ") .. " " .. spinners[frame + 1]
  return spinners[frame + 1]
end

-- REQUIRES LSP
-- local function Icon_LSP_Progress()
--   local messages = vim.lsp.status()
--   if #messages == 0 then
--     return ""
--   end
--   -- if #messages == 0 then return "" end
--
--   return format_messages_2(messages)
-- end

-- --------------------------------------------------------------------
--                   LSP Progress Icon
-- --------------------------------------------------------------------

local function Icon_LSP_Progress()
  local messages = vim.lsp.status()
  if #messages == 0 then
    return "" -- Static icon when no LSP activity
  end

  local spinners = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 80) % #spinners -- Adjusted for smoother animation
  return spinners[frame + 1]
end

-- --------------------------------------------------------------------
--                   Scroll Bar Progress
-- --------------------------------------------------------------------
local scrollbar = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  -- local chars = {
  --     " __", " ▁▁", " ▂▂", " ▃▃", " ▄▄",
  --     " ▅▅", " ▆▆", " ▇▇", " ██"
  -- }
  local chars = {
    " ██",
    " ▇▇",
    " ▆▆",
    " ▅▅",
    " ▄▄",
    " ▃▃",
    " ▂▂",
    " ▁▁",
    " __",
  }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

-- Windsurf AI generating status
local function windsurf_ai_status()
  -- Directly call the Vimscript function from Windsurf.vim
  local ok, status = pcall(vim.api.nvim_call_function, "codeium#GetStatusString", {})
  if not ok then return string.format("%s: 󱜝", "") end
  return string.format("%s: 󱜝", status)
end

-- #####################################################################
-- #                                                                   #
-- #                                                                   #
-- #                                                                   #
-- #                                                                   #
-- #                 MAIN SECTIONS CONFIGURATIONS                      #
-- #                                                                   #
-- #                                                                   #
-- #                                                                   #
-- #                                                                   #
-- #####################################################################

-- Light: GitHub Primer. Mode colours mirror the dark ones (blue/pink/purple/red/yellow/teal), white text >= 4.8:1.
local primer_light = {
  normal = {
    a = { fg = "#ffffff", bg = "#0969da", gui = "bold" },
    b = { fg = "#1f2328", bg = "#eaeef2" },
    c = { fg = "#1f2328", bg = "#f6f8fa" },
  },
  insert = { a = { fg = "#ffffff", bg = "#bf3989", gui = "bold" } },
  visual = { a = { fg = "#ffffff", bg = "#8250df", gui = "bold" } },
  replace = { a = { fg = "#ffffff", bg = "#cf222e", gui = "bold" } },
  command = { a = { fg = "#ffffff", bg = "#9a6700", gui = "bold" } },
  terminal = { a = { fg = "#ffffff", bg = "#1b7c83", gui = "bold" } },
  inactive = {
    a = { fg = "#59636e", bg = "#f6f8fa", gui = "bold" },
    b = { fg = "#59636e", bg = "#f6f8fa" },
    c = { fg = "#59636e", bg = "#f6f8fa" },
  },
}

-- lualine calls this on setup and again on every ColorScheme / OptionSet background (lualine.lua:279-280),
-- so the statusline follows <leader>ub live. Dark = the original theme + overrides, required at call time
-- (the require resolves to lualine's or githubG's onedark.lua depending on load order, same as before).
local function theme()
  if vim.o.background == "light" then return primer_light end
  -- Check .local/share/nvim/site/pack/packer/opt/lualine.nvim/lua/lualine/themes/onedark.lua
  local custom_onedark = require "lualine.themes.onedark"
  -- Change the background of lualine_c section for normal mode
  -- custom_onedark.normal.c.bg = "#2c373e"
  -- When we open/switch to another buffer (such as vsplit, nvimtree), it will be inactive
  -- In orginal common style for stausline without the (lualine) it has a name called NC
  -- (StatusLineNC = { fg = '$beautiful_black' ,bg = '$beautiful_black' } which can be added to the config of Onedark
  -- custom_onedark.inactive.a.bg = '$black'
  -- custom_onedark.inactive.b.bg = '$black'
  -- custom_onedark.inactive.c.bg = '$black'
  -- Configuations for the colors of the Normal mode
  -- custom_onedark.normal.a.fg= '#00A9A5'    -- background color
  -- custom_onedark.normal.a.bg = '#94C9A9' -- lightgreen
  custom_onedark.normal.a.bg = "#65A8EC" -- lightgreen
  custom_onedark.insert.a.bg = "#E18CA4" --
  custom_onedark.visual.a.bg = "#DCBDFB" --
  return custom_onedark
end
-- keep the original load-time require: it decides which onedark.lua is cached; theme() reuses it until
-- `colorscheme onedark` drops it from package.loaded (githubG colors/onedark.lua), then re-requires fresh
require "lualine.themes.onedark"

function M.setup()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      globalstatus = false, -- this will make the statusline expand vertically across all other opened buffered such as nvimtree
      theme = theme,
      -- theme = "github_dimmed",
      disabled_filetypes = {
        statusline = {
          "packer",
          "NvimTree",
          "Telescope",
          "Dashboard",
          "Packer",
          "FZF",
          "Alpha",
        },
        winbar = {}, -- only ignores the ft for winbar.
      },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      -- globalstatus = false,
      -- refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
      refresh = { statusline = 100, tabline = 1000, winbar = 1000 }, -- Increased refresh rate for smoother animation
    },
    sections = {
      -- lualine_a = {{[[string.format("%s","")]]}, {"mode"}},
      lualine_a = { { "mode" } }, -- { Icon_LSP_Progress },
      -- lualine_b = {'branch', 'diff', {'diagnostics',sources = {"nvim_diagnostic", "coc"}}}, --  for nvim 0.6+
      lualine_b = {
        { "branch" },
        { "diff" },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = "",
          },
          -- symbols = {
          --     error = "",
          --     information = "כֿ",
          --     hint = "",
          --     warn = ""
          -- }
          -- cond = conditions.hide_in_width,
        },
      },

      -- lualine_c = {'filename'},
      lualine_c = { { [[""]] }, { full_path } },
      lualine_x = {
        { "encoding" },
        { "filetype" },
        { lsp_func },
        -- {
        --   function()
        --     local c_preset = cmake.get_configure_preset()
        --     return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
        --   end,
        --   icon = icons.ui.Search,
        --   cond = function()
        --     return cmake.is_cmake_project() and cmake.has_cmake_preset()
        --   end,
        --   on_click = function(n, mouse)
        --     if n == 1 then
        --       if mouse == "l" then
        --         vim.cmd "CMakeSelectConfigurePreset"
        --       end
        --     end
        --   end,
        -- },
        { system_icon() },
        separator = nil,
      },
      -- lualine_x = {'encoding', 'fileformat', 'filetype'},
      -- lualine_y = {'progress'},
      lualine_y = {
        { get_file_size },

        -- { -- Shows LSP progress (animated spinner + progress message)
        --   -- function() return require("lsp-progress").progress() end,
        --   function()
        --     local status = require("lsp-progress").progress()
        --     if not status or status == "" then return "" end
        --     -- Extract spinner (after 'LSP ')
        --     local spinner = status:match "LSP%s+([%z\1-\127\194-\244][\128-\191]*)"
        --     return vim.trim(spinner or "")
        --   end,
        -- },

        { copilot_status },
        separator = nil,
      },

      -- lualine_z = {'location'}
      lualine_z = {

        { windsurf_ai_status },
        -- {"%m%5([%l/%L%)(%c)%p%%]"}, -- compatible with nvim 0.7
        -- {"%m%2([ﭨ ʟ%l/%L%)(c%c)%p%%]"}, -- compatible with nvim 0.7
        { "location" },
        -- {"progress",fmt = function() return "%p/%L"end,color = {}},
        {
          "progress",
          fmt = function(str)
            local x = "%P/%L"
            return x
          end,
          color = {},
        },
        { scrollbar, separator = nil },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      -- lualine_c = {'filename'},
      -- lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  }
end

return M
