local M = {}
local which_key_status, which_key = pcall(require, "which-key")

M.config = function()
  -- if  which_key_status then which_key.setup({}) end
  if which_key_status then
    -- method 2
    which_key.register {
      ["<leader>"] = {
        f = {
          name = "+file",
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          -- r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
          n = { "<cmd>enew<cr>", "New File" },
        },
      },
    }

    -- For debugging
    local keymap = {
      d = {
        name = "Debug",
        R = {
          "<cmd>lua require'dap'.run_to_cursor()<cr>",
          "Run to Cursor",
        },
        E = {
          "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
          "Evaluate Input",
        },
        C = {
          "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
          "Conditional Breakpoint",
        },
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        h = {
          "<cmd>lua require'dap.ui.widgets'.hover()<cr>",
          "Hover Variables",
        },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        t = {
          "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
          "Toggle Breakpoint",
        },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      },
    }
    which_key.register(keymap, {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    })

    -- Define keymap for dired file manager
    -- local keymap_dired_main = {
    --   f = {
    --     name = "Dired File Manager",
    --     j = {
    --       { ":Dired <CR>", "Toggle Dired UI" },
    --       ["<C-h>"] = { "<Plug>(dired_back)", "Go to parent directory" },
    --       ["<C-l>"] = { "<Plug>(dired_enter)", "Go to child directory" },
    --       ["."] = { "<Plug>(dired_toggle_hidden)", "Toggle hidden files" },
    --     },
    --   },
    -- }
    --
    -- which_key.register(keymap_dired_main, {
    --   mode = "n",
    --   prefix = "<leader>",
    --   buffer = nil,
    --   silent = true,
    --   noremap = true,
    --   nowait = false,
    -- })
  end
end
return M
