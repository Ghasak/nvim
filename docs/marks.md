# Marks in nvim

## Abstract

Here’s a table summarizing the commands and functionality for using marks in Vim and Neovim:

| **Action**                                  | **Command**                   | **Description**                                                                    |
| ------------------------------------------- | ----------------------------- | ---------------------------------------------------------------------------------- |
| **Set Local Mark**                          | `m{letter}`                   | Sets a local mark at the current position in the file (lowercase letters `a-z`).   |
| **Set Global Mark**                         | `m{UppercaseLetter}`          | Sets a global mark at the current position across files (uppercase letters `A-Z`). |
| **Jump to Local Mark (Exact Position)**     | `` `{letter}` ``              | Jumps to the exact position of a local mark in the same file.                      |
| **Jump to Local Mark (Beginning of Line)**  | `'{letter}'`                  | Jumps to the beginning of the line where a local mark is set in the same file.     |
| **Jump to Global Mark (Exact Position)**    | `` `{UppercaseLetter}` ``     | Jumps to the exact position of a global mark across files.                         |
| **Jump to Global Mark (Beginning of Line)** | `'{UppercaseLetter}'`         | Jumps to the beginning of the line of a global mark across files.                  |
| **View All Marks**                          | `:marks`                      | Displays a list of all marks, their locations, and files.                          |
| **Delete Single Mark**                      | `:delm {letter}`              | Deletes a specific mark (`a-z` or `A-Z`).                                          |
| **Delete Multiple Marks**                   | `:delm {letter1}{letter2}...` | Deletes multiple marks at once (e.g., `:delm a b c`).                              |
| **Delete All Marks**                        | `:delm!`                      | Deletes all marks in the current file.                                             |
| **Jump to Previous Position in File**       | `''`                          | Jumps to the previous position in the current file.                                |
| **Jump to Last Position in File**           | `'"`                          | Jumps to the last exit position in the file. Useful when reopening a file.         |
| **Jump to Last Change Position**            | `'.`                          | Jumps to the position of the last change in the file.                              |
| **Jump to Last Insert Position**            | `'^`                          | Jumps to the position of the last insert in the file.                              |
| **Set Mark in Visual Mode**                 | `m{letter}` in visual mode    | Sets a mark at the beginning of a selected area in visual mode.                    |
| **Jump Back to Previous File Position**     | `\`` `                        | Jumps to the exact position before the last jump across files.                     |

This table should serve as a quick reference to all mark-related commands in Vim and Neovim!

## Navigate marks in nvim

- I utilize the following mapping for swifter and dependable navigation between
  all the set marks.

```lua
vim.api.nvim_set_keymap("n", "<leader>mm", ":Telescope marks<CR>", { noremap = true, silent = true })
```

Marks in Vim and Neovim are powerful features for navigating and bookmarking
positions within and across files. Here’s a comprehensive guide on how to use
them effectively:

### 1. **Setting Marks in Vim and Neovim**

#### **Setting a Local Mark**

- To set a mark in the current file, move your cursor to the desired position
  and press:

  ```
  m{letter}
  ```

  where `{letter}` is any lowercase letter (`a-z`). This sets a local mark that
  only applies to the current file.

#### **Setting a Global Mark**

- To set a mark across files (global mark), use an uppercase letter:
  ```
  m{UppercaseLetter}
  ```
  where `{UppercaseLetter}` is any uppercase letter (`A-Z`). This allows you to
  return to this position from any other file in your workspace.

### 2. **Jumping to Marks**

#### **Jump to a Local Mark**

- Use:

  ```
  `{letter}
  ```

  where `{letter}` is the lowercase mark you set (`a-z`). This places your
  cursor exactly where you set the mark.

- To jump to the beginning of the line where the mark is set, use:
  ```
  '{letter}
  ```

#### **Jump to a Global Mark**

- From any file, use:
  ```
  `{UppercaseLetter}
  ```
  or
  ```
  '{UppercaseLetter}
  ```
  where `{UppercaseLetter}` is the uppercase mark set in another file.

### 3. **Viewing Marks**

- To view all current marks, enter command mode and type:
  ```
  :marks
  ```
  This shows a list of all marks, their locations, and the files in which they’re set.

### 4. **Deleting Marks**

- To delete a single mark, use:

  ```
  :delm {letter}
  ```

  where `{letter}` is the mark you want to delete (either lowercase or uppercase).

- To delete multiple marks, specify them consecutively:

  ```
  :delm {letter1}{letter2}...
  ```

- To delete all marks, use:
  ```
  :delm!
  ```

- To delete all marks read more [here](https://stackoverflow.com/questions/11450817/vim-how-do-i-clear-all-marks),

```sh
:delm! | delm A-Z0-9
```


### 5. **Navigating to Special Marks**

Vim/Neovim also creates special marks automatically:

- `''` (two single quotes): Returns to the previous position in the current file.
- `` ` `` (backtick) followed by two backticks: Returns to the exact position before the last jump across files.
- `'.`: Jumps to the position of the last change in the current file.
- `'^`: Jumps to the position of the last insert.
- `'"`: Jumps to the last exit position in the file (useful for reopening a file at the last position).

### 6. **Using Marks Across Files (Global Marks)**

Global marks (uppercase) allow you to navigate directly to positions in other files. For example:

- To set a mark in a different file, open that file and set an uppercase mark:

  ```
  mA
  ```

  (sets the `A` mark in the current file).

- To jump to that mark from any file, use:
  ```
  `A
  ```

### 7. **Using Marks in Visual Mode**

You can also mark selections using marks in visual mode. Here’s how:

- Select text in visual mode.
- Use `m{letter}` to set the mark at the beginning of the selection.

Marks can help reselect or jump back to the selected area quickly.

### 8. **Tips and Best Practices**

- **Use global marks** for frequently accessed files. This can help with
  project navigation by quickly jumping to specific points in different files.

- **Combine marks with jumps** to backtrack (e.g., by setting a mark before
  jumping to another file, then returning with `''`).

- **Avoid using too many marks** as they can clutter the workspace. Use them
  intentionally and delete unnecessary ones.

These tips should help you use marks in Vim and Neovim to organize navigation
within and across files efficiently!


## Note

In Vim and Neovim, marks are typically associated with lowercase (`a-z`) and
uppercase (`A-Z`) letters, where lowercase marks are local to the current file,
and uppercase marks are global, allowing navigation across files. The use of
numerals (`0-9`) as marks is reserved for special purposes and is not intended
for user-defined marking.

**Special Numerical Marks:**

Vim automatically assigns numerical marks (`0-9`) to track positions in files from previous editing sessions:

- `` `0``: Position in the last file edited.
- `` `1``: Position in the file edited before the last one.
- `` `2``: Position in the file edited before that.
- And so on, up to `` `9``.

These marks are managed by Vim and are not intended for manual setting or modification.

**Setting and Using Marks:**

- **Local Marks (within the same file):**
  - Set a mark: `m{letter}` (e.g., `ma` sets mark 'a').
  - Jump to the mark: `` `{letter}` `` (e.g., `` `a`` jumps to mark 'a').

- **Global Marks (across files):**
  - Set a mark: `m{UppercaseLetter}` (e.g., `mA` sets mark 'A').
  - Jump to the mark: `` `{UppercaseLetter}` `` (e.g., `` `A`` jumps to mark 'A').

For more detailed information on using marks in Vim, you can refer to the [Vim Tips Wiki on Using Marks](https://vim.fandom.com/wiki/Using_marks).

In summary, while Vim provides numerical marks for tracking positions in previously edited files, these are managed automatically and are not available for manual setting or global jumping. For user-defined marks, it's recommended to use lowercase and uppercase letters.
