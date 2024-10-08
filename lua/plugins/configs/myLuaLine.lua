---@diagnostic disable: deprecated
-- --------------------------------------------------------------------
--
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
local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

local lsp_func = function()
  -- Function that return the client language server corresponding to the
  local server_icon = "󰒍"
  local server_icon_not_not_known = "󰒍"
  local servers = {}
  local path = vim.fn.stdpath "data"
  path = string.format("%s", path)
  local clients = vim.lsp.get_active_clients()
  local buff_ft = vim.bo.filetype
  local next = next
  if next(clients) == nil then
    return string.format("%s : %s-lsp*: %s", server_icon_not_not_known, buff_ft)
  end
  for _, client in pairs(clients) do
    table.insert(servers, client)
  end
  for _, server in ipairs(servers) do
    if buff_ft == "lua" and server.name == "lua_ls" then -- [lua] For nvim 0.51 server.nam for lua is  lua, while for 0.6 it is sumneko_lua
      return string.format("%s : lua-lsp", server_icon)
    elseif buff_ft == "python" and (server.name == "pyright" or server.name == "pylsp") then --  [python] For nvim 0.51 serer.name is python , while for 0.6 it is now pyright)
      -- regular virtualenv stored in variable VIRTUAL_ENV
      local venv = os.getenv "VIRTUAL_ENV"
      if venv ~= nil then
        return string.format("%s-%s: pyright-lsp", server_icon, env_cleanup(venv))
      else
        return string.format("%s: pyright-lsp", server_icon)
      end
    elseif buff_ft == "r" and server.name == "r_language_server" then
      return string.format("%s : R-lsp", server_icon)
    elseif buff_ft == "markdown" or server.name == "ltex" then -- [Markdown] For nvim 0.51, server.name is html, while for 0.6 it is latex
      return string.format("%s : markdown-lsp", server_icon)
    elseif buff_ft == "typescript" and server.name == "tsserver" then
      return string.format("%s : typescript-lsp", server_icon)
    elseif buff_ft == "javascript" and server.name == "tsserver" then
      return string.format("%s : javascript-lsp", server_icon)
    elseif buff_ft == "julia" and server.name == "julials" then
      return string.format("%s : Julia-lsp", server_icon)
      -- Define  C++ language server
    elseif buff_ft == "cpp" and server.name == "clangd" then
      return string.format("%s : cpp-lsp", server_icon)
    elseif buff_ft == "rust" and server.name == "rust_analyzer" then
      return string.format("%s : rust_analyzer", server_icon)
    elseif buff_ft == "tex" and server.name == "texlab" or server.name == "ltex" then
      return string.format("%s :latex ", server_icon)
    else
      if server.name == "" or server.name == nil or buff_ft == "" or buff_ft == nil then
        return string.format("%s : %-lsp*:", server_icon_not_not_known)
      else
        return string.format("%s : %s-lsp*: %s", server_icon_not_not_known, buff_ft, server.name)
      end
    end
  end
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
  if size == 0 or size == -1 or size == -2 then
    return ""
  end
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
  if string.len(file) == 0 then
    return ""
  end
  return file_size(file)
end

-- --------------------------------------------------------------------
--                     HSP-Progress
--                  Work Space Loading time
-- --------------------------------------------------------------------
local function format_messages(messages)
  local result = {}
  local spinners = {
    -- "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"
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
  local frame = math.floor(ms / 120) % #spinners
  local i = 1
  -- Only display at most 2 progress messages at a time to avoid clutter
  for _, msg in pairs(messages) do
    if i < 3 then
      table.insert(result, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
      i = i + 1
    end
  end
  return table.concat(result, " ") .. " " .. spinners[frame + 1]
end

-- REQUIRES LSP
local function hsp_progress()
  --local messages = vim.lsp.util.get_progress_messages()
  local messages = vim.lsp.status()
  if #messages == 0 then
    return ""
  end
  return format_messages(messages)
end

-- --------------------------------------------------------------------
--                    Copilot status
-- --------------------------------------------------------------------
local function copilot_status()
  local copilot_icon_loaded = "  󰚩 "
  local copilot_icon_not_loaded = "  󰚩 "

  if vim.fn.exists "g:copilot_enabled" == 1 then
    if vim.inspect(vim.api.nvim_get_var "copilot_enabled") == "true" then
      -- return true if copilot is installed and set to be enabled
      return string.format("%s", copilot_icon_loaded)
    else
      return string.format("%s", copilot_icon_not_loaded)
    end
  else
    return string.format("%s", copilot_icon_not_loaded)
  end
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
local function Icon_LSP_Progress()
  local messages = vim.lsp.status()
  if #messages == 0 then
    return ""
  end
  -- if #messages == 0 then return "" end

  return format_messages_2(messages)
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

-- Check .local/share/nvim/site/pack/packer/opt/lualine.nvim/lua/lualine/themes/onedark.lua
local custom_onedark = require "lualine.themes.onedark"
-- Change the background of lualine_c section for normal mode
-- custom_onedark.normal.c.bg = '$black'
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

function M.setup()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      globalstatus = false, -- this will make the statusline expand vertically across all other opened buffered such as nvimtree
      theme = custom_onedark,
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
      -- globalstatus = false,
      refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
    },
    sections = {
      -- lualine_a = {{[[string.format("%s","")]]}, {"mode"}},
      lualine_a = { { Icon_LSP_Progress }, { "mode" } },
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
        { hsp_progress },
        { copilot_status },
        separator = nil,
      },

      -- lualine_z = {'location'}
      lualine_z = {
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
