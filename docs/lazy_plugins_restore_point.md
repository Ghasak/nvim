# Lazy Restore Plugins

lazy.nvim has first-class support for a **lockfile** (`lazy-lock.json`) that
pins every plugin to the exact Git commit you have installed. You don’t need to
hard-code branches one-by-one—just let lazy.nvim snapshot your current state
and then restore from that snapshot whenever you like.

---

## Loading Even

📝 **lazy.nvim Snapshot Automation Guide**

**Purpose**
📌 Pin plugin versions by snapshotting your `lazy-lock.json`
📌 Safely update plugins knowing you can roll back
📌 Keep a history of dated snapshots for auditing or testing

---

**Setup**

1. **Define where snapshots live** (in your `init.lua`):
   ```lua
   -- Directory under $XDG_DATA_HOME/nvim to store snapshots
   local snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"
   ```
2. **Hook into lazy.nvim’s update event**:
   ```lua
   vim.api.nvim_create_autocmd("User", {
     pattern = "LazyUpdatePre",
     callback = function()
       -- Ensure the snapshot folder exists
       vim.fn.mkdir(snapshot_dir, "p")
       -- Paths for current lockfile & timestamped backup
       local src  = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
       local dest = string.format(
         "%s/%s.json",
         snapshot_dir,
         os.date("%Y-%m-%dT%H:%M:%S")
       )
       -- Copy the lockfile
       vim.loop.fs_copyfile(src, dest)
     end,
   })
   ```

---

**Key Lines Explained**

- 📁 `snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"`
   Defines a subfolder under `~/.local/share/nvim` for your backups.
- 🔄 `vim.fn.mkdir(snapshot_dir, "p")`
   Creates the folder (and parents) only if it doesn’t already exist.
- 📂 `src = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"`
   Points to lazy.nvim’s default lockfile location.
- 🕑 `os.date("%%Y-%%m-%%dT%%H:%%M:%%S")`
   Generates an ISO-style timestamp for unique filenames.
- 📝 `vim.loop.fs_copyfile(src, dest)`
   Copies the lockfile using Neovim’s libuv-based I/O.
- ⚡ `pattern = "LazyUpdatePre"`
   Triggers **before** you run `:Lazy update`, capturing the pre-update state.

---

**How to Use**

1. **Add** the snippet above to your Neovim config (e.g. `init.lua`).
2. **Run** `:Lazy update` as usual—each time, a timestamped backup of your lockfile appears in `~/.local/share/nvim/lazy-snapshots`.
3. **List** your snapshots in your shell:
   ```
   ls ~/.local/share/nvim/lazy-snapshots
   ```
4. **Restore** a backup:
   ```bash
   cp ~/.local/share/nvim/lazy-snapshots/2025-04-30T18:15:42.json \
      ~/.config/nvim/lazy-lock.json
   # Then inside Neovim:
   :Lazy restore
   ```

---

**Optional: Manual Checkpoints**
You can also manually save named snapshots anytime:

```bash
cp ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock-mylabel.json
```

Restore by copying it back to `lazy-lock.json` and running `:Lazy restore`.

---

**Icon Legend**

- 📁 Directory operations
- 🔄 Autocommand setup
- 📂 File path references
- 🕑 Timestamp generation
- 📝 File copy action
- ⚡ Event pattern trigger

---

### 1. Enable and locate the lockfile

By default lazy.nvim will write a `lazy-lock.json` in your Neovim config
directory (usually `~/.config/nvim/lazy-lock.json`), but you can also customize
it in your `init.lua`:

```lua
require("lazy").setup("plugins", {
  -- ... your plugin specs here ...
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
})
```

([⚙️ Configuration | lazy.nvim](https://lazy.folke.io/configuration))

---

### 2. Take your “restore point”

1. **Install or update** your plugins exactly as you want (e.g. run `:Lazy update`, or on startup with `install.missing = true`).
2. **Commit** the generated `lazy-lock.json` into your dotfiles repo:

   ```bash
   git add ~/.config/nvim/lazy-lock.json
   git commit -m "📌 lock plugins @ my current working set"
   ```

3. Now you have a restore point—every plugin’s repo-wide commit SHA is frozen in that JSON.

---

### 3. Restoring to exactly that state

On any machine (or after a bad `:Lazy update`), simply:

```vim
:Lazy restore
```

This will read `lazy-lock.json` and check out each plugin at the recorded
commit, without ever pulling the latest upstream changes ([ Lockfile |
lazy.nvim](https://lazy.folke.io/usage/lockfile)). If you prefer to restore a
single plugin:

```vim
:Lazy restore nvim-treesitter
```

---

### 4. Keeping multiple snapshots (optional)

If you’d like named snapshots beyond your `git` history, you can **manually
back up** the lockfile before updates:

```bash
cp ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock-$(date +%F_%T).json
```

Or automate it with an autocommand (in your `init.lua`):

```lua
local snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyUpdatePre",
  callback = function()
    vim.fn.mkdir(snapshot_dir, "p")
    local src = vim.fn.stdpath("config") .. "/lazy-lock.json"
    local dest = string.format("%s/%s.json", snapshot_dir, os.date("%Y-%m-%dT%H:%M:%S"))
    vim.loop.fs_copyfile(src, dest)
  end,
})
-- Later you can switch back by copying your chosen snapshot to lazy-lock.json and running :Lazy restore
```

This way, you never have to manually pin branches in your spec—lazy.nvim’s
lockfile mechanism handles it all.

---

# 📝 **lazy.nvim Snapshot Automation Documentation**

A concise guide to automatically snapshotting and restoring your plugin lockfile (`lazy-lock.json`) in Neovim using `lazy.nvim` and Lua autocommands.

---

## 🎯 Purpose

- **Pin plugin versions**: Create a point-in-time backup of your exact plugin commit SHAs.
- **Safe updates**: Roll back to a known-good state if a `:Lazy update` introduces issues.
- **History of snapshots**: Maintain multiple dated backups for auditing or testing.

---

## 🛠️ Setup

1. **Define a snapshot directory** in your `init.lua` or a dedicated Lua module:
   ```lua
   -- Path to store snapshots (e.g., ~/.local/share/nvim/lazy-snapshots)
   local snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"
   ```
2. **Register an autocommand** to fire **before** `lazy.nvim` updates:

   ```lua
   vim.api.nvim_create_autocmd("User", {
     pattern = "LazyUpdatePre",
     callback = function()
       -- Create snapshot_dir (and parents) if missing
       vim.fn.mkdir(snapshot_dir, "p")

       -- Source and destination paths
       local src  = vim.fn.stdpath("config") .. "/lazy-lock.json"
       local dest = string.format(
         "%s/%s.json",
         snapshot_dir,
         os.date("%Y-%m-%dT%H:%M:%S")
       )

       -- Copy lockfile to timestamped backup
       vim.loop.fs_copyfile(src, dest)
     end,
   })
   ```

---

## 📋 Explanation of Key Lines

| Icon | Code Snippet                                                       | Explanation                                                            |
| :--: | :----------------------------------------------------------------- | :--------------------------------------------------------------------- |
|  📁  | `local snapshot_dir = vim.fn.stdpath("data") .. "/lazy-snapshots"` | Sets a folder under `$XDG_DATA_HOME/nvim` to store backups.            |
|  🔄  | `vim.fn.mkdir(snapshot_dir, "p")`                                  | Creates the directory (with parents) only if it doesn’t exist.         |
|  📂  | `local src = vim.fn.stdpath("config") .. "/lazy-lock.json"`        | Points to the current lockfile in your Neovim config directory.        |
|  🕑  | `os.date("%Y-%m-%dT%H:%M:%S")`                                     | Generates an ISO timestamp for unique filenames.                       |
|  📝  | `vim.loop.fs_copyfile(src, dest)`                                  | Performs the file copy using Neovim’s built-in libuv wrapper.          |
|  ⚡  | `pattern = "LazyUpdatePre"`                                        | Hooks **before** `:Lazy update` runs to snapshot the pre-update state. |

---

## 🚀 Usage

1. **Initial setup**: Add the above snippet to your `init.lua` (or a sourced Lua module).
2. **Triggering a snapshot**:
   - Every time you run `:Lazy update`, the hook creates a timestamped backup of `lazy-lock.json`.
3. **Listing snapshots**:
   ```bash
   ls ~/.local/share/nvim/lazy-snapshots
   ```
4. **Restoring a snapshot**:
   ```bash
   # Overwrite current lockfile with a specific backup
   cp ~/.local/share/nvim/lazy-snapshots/2025-04-30T18:15:42.json ~/.config/nvim/lazy-lock.json
   # Then in Neovim…
   :Lazy restore
   ```

---

## 🔧 Optional: Multiple Named Snapshots

If you want manual checkpoints:

```bash
cp ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock-<label>.json
```

Then restore by copying back to `lazy-lock.json` and running `:Lazy restore`.

---

## 📖 Icons Legend

- 📁 Directory operations
- 🔄 Autocommand & Hook points
- 📂 File paths
- 🕑 Timestamp generation
- 📝 File copy action
- ⚡ Event pattern

---

_Snippet courtesy of `lazy.nvim` lockfile features & Neovim's Lua API™._
