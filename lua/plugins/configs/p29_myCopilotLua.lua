--
--        █▀▀ █▀█ █▀█ █ █░░ █▀█ ▀█▀   ▄▄   █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀
--        █▄▄ █▄█ █▀▀ █ █▄▄ █▄█ ░█░   ░░   █▄▄ █▄█ █░▀█ █▀░ █ █▄█
--

local function is_installed(name)
  local ok = pcall(require, name)
  return ok
end

-- Notify via snacks.nvim if installed
local function notify_snacks_status()
  if is_installed "snacks" then
    local snacks = require "snacks"
    snacks.notify {
      title = "Plugin Status",
      message = "snacks.nvim is installed and loaded",
      level = "info",
    }
  end
end

local M = {}

M.setting = function()
  -- 1) check that copilot.lua is loaded and inline suggestions are enabled
  local ok_conf, conf = pcall(require, "copilot.config")
  if not ok_conf or not (conf.opts and conf.opts.suggestion and conf.opts.suggestion.enabled) then return end

  -- 2) install our autocmd to watch for any InsertEnter
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      -- safely require the suggestion API
      local ok_sug, sug = pcall(require, "copilot.suggestion")
      if not ok_sug or not sug.is_visible() then return end

      -- 3) if a suggestion is showing, notify via snacks (or vim.notify)
      if pcall(require, "snacks") then
        require("snacks").notify {
          title = "Copilot Suggestion",
          message = "WOWOOWOWOW",
          level = "info",
        }
      else
        vim.notify "WOWOOWOWOW"
      end
    end,
  })
end

return M
