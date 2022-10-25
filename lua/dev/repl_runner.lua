local M = {}
M.setup = function()

  -- 1. You need to know the buffer number
  -- lua print(vim.api.nvim_get_current_buf())
  -- local code_buf = vim.api.nvim_get_current_buf()
  --vim.cmd([[vsp | b "wow_buffer" ]])
  -- vim.cmd([[vert sb N ]])
  -- local repl_buf = vim.api.nvim_get_current_buf()
  -- vim.pretty_print("Code Buffer Number is = " .. code_buf .. "and repl buffer number = " .. repl_buf)
  -- create a new, scratch buffer, for fzf
  --  local buf = vim.api.nvim_create_buf(false, true)
  --  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  --vim.cmd([[vsp | b "buf"]])
  -- local win = vim.api.nvim_open_win(buf, true, opts)
  --vim.pretty_print({"1", "wow"})

  local bn = vim.api.nvim_get_current_buf()
  local wn = vim.api.nvim_get_current_win()
  --local code = vim.api.nvim_buf_get_lines(code_buf,0, -1, false)
  --local code = vim.api.nvim_buf_set_lines(code_buf, 0, 1, false, { "Hello" })
  --vim.pretty_print(table.concat(code, "\n"))
  --vim.pretty_print(vim.api.nvim_win_set_buf(wn,bn))

  -- local code = vim.api.nvim_buf_get_lines(bn, 0, -1, false)
  -- vim.pretty_print(code)

  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  -- local curline = vim.api.nvim_buf_get_lines(bn, linenr - 1, linenr, false)[1]
  -- print(string.format("Current line [%d] has %d bytes", linenr, curline))
  vim.pretty_print(linenr)



  --------------------------------------------------
  function NavigationFloatingWin()
    -- get the editor's max width and height
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- create a new, scratch buffer, for fzf
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    -- if the editor is big enough
    if (width > 150 or height > 35) then
      -- fzf's window height is 3/4 of the max height, but not more than 30
      local win_height = math.min(math.ceil(height * 3 / 4), 30)
      local win_width

      -- if the width is small
      if (width < 150) then
        -- just subtract 8 from the editor's width
        win_width = math.ceil(width - 8)
      else
        -- use 90% of the editor's width
        win_width = math.ceil(width * 0.9)
      end

      -- settings for the fzf window
      local opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = math.ceil((height - win_height) / 2),
        col = math.ceil((width - win_width) / 2),
        border = {
          "╔", "═", "╗", "║", "╝", "═", "╚", "║"
          --"╭", "─", "╮", "│", "╯", "─", "╰", "│"
          --  "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌"
        }
      }

      -- create a new floating window, centered in the editor
      local win = vim.api.nvim_open_win(buf, true, opts)
      return win
    end
  end

  --local win = vim.api.nvim_open_win(buf, true, opts)
  -- optional: change highlight, otherwise Pmenu is used
  --vim.api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
  local win = NavigationFloatingWin()
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
















  -- --local code = vim.api.nvim_buf_get_lines(code_buffer, 0, -1, false)
  -- local code = vim.api.nvim_buf_get_lines(code_buf, 0, -1, false)
  -- vim.pretty_print(code)
  -- -- get the editor's max width and height
  -- local width = vim.api.nvim_get_option("columns")
  -- local height = vim.api.nvim_get_option("lines")
  --
  -- -- create a new, scratch buffer, for fzf
  -- local buf = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  --
  -- -- if the editor is big enough
  -- if (width > 150 or height > 35) then
  --   -- fzf's window height is 3/4 of the max height, but not more than 30
  --   local win_height = math.min(math.ceil(height * 3 / 4), 30)
  --   local win_width
  --
  --   -- if the width is small
  --   if (width < 150) then
  --     -- just subtract 8 from the editor's width
  --     win_width = math.ceil(width - 8)
  --   else
  --     -- use 90% of the editor's width
  --     win_width = math.ceil(width * 0.9)
  --   end
  --
  --   -- settings for the fzf window
  --   local opts = {
  --     relative = "editor",
  --     width = win_width,
  --     height = win_height,
  --     row = math.ceil((height - win_height) / 2),
  --     col = math.ceil((width - win_width) / 2),
  --     --border = "rounded"
  --     -- border = 'rounded',
  --     border = {
  --       "╔", "═", "╗", "║", "╝", "═", "╚", "║"
  --       --"╭", "─", "╮", "│", "╯", "─", "╰", "│"
  --       --  "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌"
  --     }
  --   }
  --   -- create a new floating window, centered in the editor
  --   local win = vim.api.nvim_open_win(buf, true, opts)
  --   local repl__buffer_num = vim.api.nvim_get_current_buf()
  --   -- vim.api.nvim_buf_set_lines(code_buffer, 0,-1,false,{"We are now at buffer: " .. repl__buffer } )
  --   --vim.fn.jobstart({ "python3", "-c", 'print("This is just a string ...")' },
  --   vim.fn.jobstart({ "python3", "-m", "main"},
  --     {
  --       stdout_buffered = true,
  --       stderr_buffered = true,
  --       on_stdout = function(_, data)
  --         vim.api.nvim_buf_set_lines(repl__buffer_num, 0, -1, false,data)
  --       end
  --
  --     }
  --   )
  --
  -- end

end
return M
