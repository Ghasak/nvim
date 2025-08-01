local M = {}

M.config = function()
  -- Case insesneitive searching UNLESS /C or captial in search
  vim.o.ignorecase = true
  vim.o.smartcase = true
  -- Decrease update time
  vim.o.updatetime = 250
  vim.wo.signcolumn = "yes"

  vim.o.completeopt = "menuone,noselect"

  vim.g.db_ui_use_nerd_fonts = 1
  -- Create an autocommand group for DBUI
  vim.api.nvim_create_augroup("DBUINotifyConfig", { clear = true })
  -- Set up an autocommand to configure nvim-notify when entering DBUI
  vim.api.nvim_create_autocmd("FileType", {
    group = "DBUINotifyConfig",
    pattern = "dbui",
    callback = function()
      vim.g.db_ui_use_nvim_notify = 1
      vim.notify = require "notify"
      vim.g.db_ui_notification_mode = "nvim-notify"
    end,
  })

  local client_notifs = {}

  local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then client_notifs[client_id] = {} end

    if not client_notifs[client_id][token] then client_notifs[client_id][token] = {} end

    return client_notifs[client_id][token]
  end

  local function format_message(number) return "Executing query - " .. tostring(number) .. "s" end

  local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

  local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
      local new_spinner = (notif_data.spinner + 1) % #spinner_frames
      notif_data.spinner = new_spinner
      local start_time = notif_data.notification.start_time
      local current_time = vim.uv.clock_gettime "monotonic"
      ---@diagnostic disable-next-line: need-check-nil
      local interval = (current_time.sec * 1e9 + current_time.nsec - start_time.sec * 1e9 - start_time.nsec) / 1e9
      local message = format_message(interval)

      ---@diagnostic disable-next-line: param-type-mismatch
      notif_data.notification = vim.notify(message, "info", {
        hide_from_history = true,
        icon = spinner_frames[new_spinner],
        replace = notif_data.notification,
      })
      notif_data.notification.start_time = start_time

      vim.defer_fn(function() update_spinner(client_id, token) end, 100)
    end
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = { "DBQueryPre", "*DBExecutePre" },
    callback = function(event)
      local token = event.buf

      local notif_data = get_notif_data("dadbod-ui", token)

      local message = format_message(0.0)

      notif_data.notification = vim.notify(message, "info", {
        title = "[DBUI]",
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = false,
      })
      notif_data.notification.start_time = vim.uv.clock_gettime "monotonic"

      notif_data.spinner = 1
      update_spinner("dadbod-ui", token)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = { "DBQueryPost", "*DBExecutePost" },
    callback = function(event)
      local token = event.buf

      local notif_data = get_notif_data("dadbod-ui", token)

      notif_data.notification = vim.notify(nil, nil, {
        hide_from_history = true,
        icon = "",
        replace = notif_data.notification,
        timeout = 0,
      })

      notif_data.spinner = nil
    end,
  })
end
return M
