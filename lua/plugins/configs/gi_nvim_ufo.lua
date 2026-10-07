local M = {}

M.config = function()
  -- ******************************************************************************************

  -- ███████╗░█████╗░██╗░░░░░██████╗░██╗███╗░░██╗░██████╗░  ░█████╗░░█████╗░██████╗░███████╗
  -- ██╔════╝██╔══██╗██║░░░░░██╔══██╗██║████╗░██║██╔════╝░  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
  -- █████╗░░██║░░██║██║░░░░░██║░░██║██║██╔██╗██║██║░░██╗░  ██║░░╚═╝██║░░██║██║░░██║█████╗░░
  -- ██╔══╝░░██║░░██║██║░░░░░██║░░██║██║██║╚████║██║░░╚██╗  ██║░░██╗██║░░██║██║░░██║██╔══╝░░
  -- ██║░░░░░╚█████╔╝███████╗██████╔╝██║██║░╚███║╚██████╔╝  ╚█████╔╝╚█████╔╝██████╔╝███████╗
  -- ╚═╝░░░░░░╚════╝░╚══════╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░  ░╚════╝░░╚════╝░╚═════╝░╚══════╝
  -- The following configurations will be triggered once you
  -- use the command `:UFOAttach`. Then you can fold under the
  -- cursor using <leader>1 or fold/unfold for all using <leader>.
  -- ******************************************************************************************

  -- *********************************************
  --   CONFIGURATOINS FOR THE GUTTER FOR FOLDING
  -- *********************************************
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  vim.o.foldcolumn = "1" -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  -- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  -- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  -- vim.keymap.set("n", "<leader>1", require("ufo").openAllFolds, { desc = "Open all folds" })
  -- vim.keymap.set("n", "<leader>2", require("ufo").closeAllFolds, { desc = "Open all folds" })

  -- *****************************
  --   KEYBINDING FOR FOLDING - ALL
  -- *****************************
  vim.keymap.set("n", "<leader>1", function()
    local winid = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(winid)
    local line = cursor[1]

    if vim.wo[winid].foldenable and vim.fn.foldclosed(line) > -1 then
      -- If fold is closed at current line, open all folds in the buffer
      vim.api.nvim_exec2([[foldopen]], { output = true })
    else
      -- If fold is not closed at current line, close all folds in the buffer
      vim.api.nvim_exec2([[foldclose]], { output = true })
    end
  end, { desc = "Toggle all folds based on the current line's fold state" })

  -- *****************************
  --   KEYBINDING FOR FOLDING - ALL
  -- *****************************
  vim.keymap.set("n", "<leader>2", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(winid)
    local line = cursor[1]
    local ufo = require "ufo"

    if vim.wo[winid].foldenable and vim.fn.foldclosed(line) > -1 then
      -- If fold is closed at current line, open all folds in the buffer
      ufo.openAllFolds(bufnr)
    else
      -- If fold is not closed at current line, close all folds in the buffer
      ufo.closeAllFolds(bufnr)
    end
  end, { desc = "Toggle all folds based on the current line's fold state" })

  -- *****************************
  --   KEYBINDING FOR FOLDING Peeking
  -- *****************************
  vim.keymap.set("n", "<leader>3", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    else
      vim.notify("There is no fold code under cursor ...", vim.log.levels.INFO)
    end
  end, { desc = "Peek Fold" })

  -- *****************************
  -- CUSTOME THEME FOR THE UFO
  -- *****************************
  -- `hi` merges fg only (theme bg kept); re-applied on ColorScheme so <leader>ub switches live.
  -- Registered before ufo's own ColorScheme handler, whose `hi default link` then leaves these alone.
  local function set_fold_hl()
    local fg = vim.o.background == "light" and "#0550ae" or "#7faed5"
    for _, group in ipairs {
      "UfoPreviewThumb", "UfoPreviewWinBar", "UfoPreviewSbar", "UfoPreviewCursorLine",
      "UfoFoldedEllipsis", "UfoCursorFoldedLine",
    } do
      vim.cmd(("hi %s guifg=%s"):format(group, fg))
    end
    if vim.o.background == "dark" then -- light: Folded/FoldColumn come from the theme (c.blue)
      for _, group in ipairs { "Folded", "FoldColumn" } do
        vim.cmd(("hi %s guifg=%s"):format(group, fg))
      end
    end
  end
  set_fold_hl()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("GiUfoFoldColors", { clear = true }),
    callback = set_fold_hl,
  })

  -- *****************************
  --    UFO MAIN SETUP FUNCTION
  -- *****************************
  require("ufo").setup {
    open_fold_hl_timeout = 150,
    --close_fold_kinds = { "imports", "comment" },
    close_fold_kinds_for_ft = { "imports", "comment" },
    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
      },
    },
    -- *****************************
    -- TYPE OF PROVIDER FOR FOLDING
    -- *****************************
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype)
      if filetype == "lua" then
        return { "indent" }
      else
        return { "lsp", "indent" }
      end
    end,
  }
end

return M
