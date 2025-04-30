-- 📝 **lazy.nvim Snapshot Automation Guide**
--
-- **Purpose**
-- 📌 Pin plugin versions by snapshotting your `lazy-lock.json`
-- 📌 Safely update plugins knowing you can roll back
-- 📌 Keep a history of dated snapshots for auditing or testing
--
-- ---
--
-- **Setup**
-- 1. **Define where snapshots live** (in your `init.lua`):
--    ```lua
--    -- Directory under $XDG_DATA_HOME/nvim to store snapshots
--    local snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"
--    ```
-- 2. **Hook into lazy.nvim’s update event**:
--    ```lua
--    vim.api.nvim_create_autocmd("User", {
--      pattern = "LazyUpdatePre",
--      callback = function()
--        -- Ensure the snapshot folder exists
--        vim.fn.mkdir(snapshot_dir, "p")
--        -- Paths for current lockfile & timestamped backup
--        local src  = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
--        local dest = string.format(
--          "%s/%s.json",
--          snapshot_dir,
--          os.date("%Y-%m-%dT%H:%M:%S")
--        )
--        -- Copy the lockfile
--        vim.loop.fs_copyfile(src, dest)
--      end,
--    })
--    ```
-- ---
--
-- **Key Lines Explained**
-- - 📁 `snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"`
--   Defines a subfolder under `~/.local/share/nvim` for your backups.
-- - 🔄 `vim.fn.mkdir(snapshot_dir, "p")`
--   Creates the folder (and parents) only if it doesn’t already exist.
-- - 📂 `src = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"`
--   Points to lazy.nvim’s default lockfile location.
-- - 🕑 `os.date("%%Y-%%m-%%dT%%H:%%M:%%S")`
--   Generates an ISO-style timestamp for unique filenames.
-- - 📝 `vim.loop.fs_copyfile(src, dest)`
--   Copies the lockfile using Neovim’s libuv-based I/O.
-- - ⚡ `pattern = "LazyUpdatePre"`
--   Triggers **before** you run `:Lazy update`, capturing the pre-update state.
--
-- ---
--
-- **How to Use**
-- 1. **Add** the snippet above to your Neovim config (e.g. `init.lua`).
-- 2. **Run** `:Lazy update` as usual—each time, a timestamped backup of your lockfile appears in `~/.local/share/nvim/lazy-snapshots`.
-- 3. **List** your snapshots in your shell:
--    ```
--    ls ~/.local/share/nvim/lazy-snapshots
--    ```
-- 4. **Restore** a backup:
--    ```bash
--    cp ~/.local/share/nvim/lazy-snapshots/2025-04-30T18:15:42.json \
--       ~/.config/nvim/lazy-lock.json
--    # Then inside Neovim:
--    :Lazy restore
--    ```
--
-- ---
--
-- **Optional: Manual Checkpoints**
-- You can also manually save named snapshots anytime:
-- ```bash
-- cp ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock-mylabel.json
-- ```
-- Restore by copying it back to `lazy-lock.json` and running `:Lazy restore`.
--
-- ---
--
-- **Icon Legend**
-- - 📁 Directory operations
-- - 🔄 Autocommand setup
-- - 📂 File path references
-- - 🕑 Timestamp generation
-- - 📝 File copy action
-- - ⚡ Event pattern trigger
--
--
--

-- Directory under $XDG_DATA_HOME/nvim to store snapshots
local snapshot_dir = vim.fn.stdpath "data" .. "/lazy-snapshots"

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyUpdatePre",
  callback = function()
    -- Ensure the snapshot folder exists
    vim.fn.mkdir(snapshot_dir, "p")
    -- Paths for current lockfile & timestamped backup
    local src = vim.fn.stdpath "data" .. "/lazy/lazy-lock.json"
    local dest = string.format("%s/%s.json", snapshot_dir, os.date "%Y-%m-%dT%H:%M:%S")
    -- Copy the lockfile
    vim.loop.fs_copyfile(src, dest)
  end,
})
