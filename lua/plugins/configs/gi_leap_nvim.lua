local M = {}

M.setup = function()
  -- 1) unmap any existing `s`/`S` first
  -- NOTE:
  -- netrw (the built-in file-browser) defines s/S in its buffer to sort listings.
  -- leap.set_default_mappings() by default will bind s → <Plug>(leap-forward-to) and S → <Plug>(leap-backward-to).
  -- When it sees those keys already taken, it prints a warning but then skips overwriting them.
  -- you will run with conflict if you dont srtip thsese (s/S) at frist
  -- In a netrw buffer (i.e. when you’ve done :Explore, :Sexplore or :Vexplore), the single‐letter keys s and S are not motions at all but rather sorting commands:
  -- s → :call <SNR>…_NetrwSortStyle(1)
  -- Cycles the sort style through the available options (e.g. sort by name, extension, size, modification-time, then back to name).
  -- S → :<C-U>call <SNR>…_NetSortSequence(1)
  -- Toggles the sort sequence (typically switching between ascending ↔ descending order).
  -- That’s why leap.nvim warns when it tries to bind s/S: netrw has already claimed them for its directory-sorting features. If you want to keep those netrw bindings around you’ll need to pick other keys for your two-char leaps (or explicitly remove the netrw mappings before installing Leap’s).

  for _, mode in ipairs { "n", "x", "o" } do
    pcall(vim.keymap.del, mode, "s")
    pcall(vim.keymap.del, mode, "S")
  end
  -- 2) Now install Leap’s defaults cleanly
  -- by default thsee are mapped (s/S)
  require("leap").set_default_mappings()

  -- 3) now we will make the search more fancy
  -- we will use the highlight color of Incsearch which
  -- will be changed when inside the leap and back to normal after leaving.
  local leap = require "leap"

  -- 1) Show only your 2-char labels, dim all the rest of the match-preview
  leap.opts.highlight_unlabeled_phase_one_targets = true

  -- 2) (Optional) Cap how many targets get labeled before grouping
  leap.opts.max_phase_one_targets = 100

  -- 3) Define a “backdrop” group that dims non-matched text
  --    (linking to Comment often looks best)
  vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

  -- 4) (Experimental) If you want the little “boxes” to sit flush
  --    instead of popping out, you can zero-offset the extmarks:
  leap.opts.on_beacons = function(targets, _, _)
    for _, t in ipairs(targets) do
      if t.label and t.beacon then
        -- beacon = { offset, extmark_opts }, setting offset to 0
        t.beacon[1] = 0
      end
    end
    return true
  end
  -- re-map with a clear-hlsearch step
  vim.keymap.set(
    "n",
    "s",
    ":silent! noh<CR><Plug>(leap-forward-to)",
    { silent = true, desc = "Leap forward (and clear search)" }
  )
  vim.keymap.set(
    "n",
    "S",
    ":silent! noh<CR><Plug>(leap-backward-to)",
    { silent = true, desc = "Leap backward (and clear search)" }
  )

  -- 1) Grab the existing Search / IncSearch highlights so we can restore them:
  local orig_search = vim.api.nvim_get_hl(0, { name = "Search" })
  local orig_incsearch = vim.api.nvim_get_hl(0, { name = "IncSearch" })

  -- 2) When Leap starts, clear out the amber highlights:
  vim.api.nvim_create_autocmd("User", {
    pattern = "LeapEnter",
    callback = function()
      vim.api.nvim_set_hl(0, "Search", { bg = "#4fb9ff", fg = "#e9f6fb" })
      vim.api.nvim_set_hl(0, "IncSearch", { bg = "#fd6963", fg = "#e9f6fb" })
    end,
  })

  -- 3) When Leap ends, restore your original colors:
  vim.api.nvim_create_autocmd("User", {
    pattern = "LeapLeave",
    callback = function()
      vim.api.nvim_set_hl(0, "Search", orig_search)
      vim.api.nvim_set_hl(0, "IncSearch", orig_incsearch)
    end,
  })
end

return M
