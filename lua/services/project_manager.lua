-- ╭──────────────────────────────────────────────────────────────╮
-- │ 🌟 Robust session management (create / pick)                 │
-- ╰──────────────────────────────────────────────────────────────╯
-- ----------------------------------------------------------------------------------------
--                         Telescope Session Function
-- ----------------------------------------------------------------------------------------
-- Current function is used to switch to environment
-- To create an environment use: mksession ~/.cache/nvim/sessions/<session_environment_name>
-- We will map this function to the <leader><leader>p to load any project/session faster
-- Read more about making sessions here:
-- https://bocoup.com/blog/sessions-the-vim-feature-you-probably-arent-using
-- ----------------------------------------------------------------------------------------

_G.open_session = function()
  local path = vim.fn.expand "~/.cache/nvim/sessions/"
  local ok, picker = pcall(require, "telescope.builtin")

  if not ok then
    vim.notify("Telescope is not available.", vim.log.levels.ERROR)
    return
  end

  picker.find_files {
    sorting_strategy = "ascending",
    find_command = {
      "fd",
      ".",
      "--type",
      "file",
      "--hidden",
      "--strip-cwd-prefix",
    },

    layout_config = {
      vertical = { mirror = false },
      width = 0.8,
      height = 10,
    },
    preview = {
      check_mime_type = false,
      timeout = 100,
    },
    color_devicons = true,
    shorten_path = false,
    cwd = path,
    prompt_title = "~ nvim session dir ~",
    hidden = false,

    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()

        if not selection then
          vim.notify("No session selected!", vim.log.levels.WARN)
          return
        end

        local environment_name = selection[1]
        local full_path = path .. environment_name

        actions.close(prompt_bufnr)
        vim.cmd("source " .. vim.fn.fnameescape(full_path))

        -- Asynchronous Notification
        local async = require "plenary.async"
        local notify = require("notify").async

        async.run(function()
          local message = string.format("Switching to: %s at %s ...", tostring(environment_name), os.date "%H:%M:%S")
          notify(message, vim.log.levels.INFO, { title = "Initializing Env." })
        end)
      end)

      return true
    end,
  }
end




