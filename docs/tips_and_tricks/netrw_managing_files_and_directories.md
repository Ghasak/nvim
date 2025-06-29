# **Managing Files and Directories with Netrw in Neovim**

This table provides a comprehensive overview of how to manage **files and
folders** using Netrw, including essential commands for **file actions, folder
actions, and additional features**.


<!-- vim-markdown-toc Marked -->

* [Accessing the Netrw from anywhere](#accessing-the-netrw-from-anywhere)
* [**Table: Netrw Commands for Files and Directories**](#**table:-netrw-commands-for-files-and-directories**)
    * [**File Actions**](#**file-actions**)
    * [**Folder (Directory) Actions**](#**folder-(directory)-actions**)
    * [**Other Features and Useful Commands**](#**other-features-and-useful-commands**)
* [**Additional Tips**](#**additional-tips**)
* [**Conclusion**](#**conclusion**)
* [**1. Use `y` and `p` to Copy and Create New Files/Directories**](#**1.-use-`y`-and-`p`-to-copy-and-create-new-files/directories**)
* [**2. Rename Files or Directories with `R`**](#**2.-rename-files-or-directories-with-`r`**)
* [**3. Using Registers for Smarter Naming and Copying**](#**3.-using-registers-for-smarter-naming-and-copying**)
* [**4. Example Workflow: Copy and Rename a Directory**](#**4.-example-workflow:-copy-and-rename-a-directory**)
* [**Summary Table of Key Actions**](#**summary-table-of-key-actions**)
* [**Conclusion**](#**conclusion**)

<!-- vim-markdown-toc -->

---

## Accessing the Netrw from anywhere

You can use

```
:Explore
```

to edit anyfile use

```
:e <file_name>
```

## **Table: Netrw Commands for Files and Directories**

### **File Actions**

| **Action**                        | **Command**                                            | **Description**                                        |
| --------------------------------- | ------------------------------------------------------ | ------------------------------------------------------ |
| **Create New File**               | `%`                                                    | Prompts to create a new file in the current directory. |
| **Delete File**                   | Move to file → `D` → Confirm with `y`                  | Deletes the selected file after confirmation.          |
| **Rename or Move File**           | Move to file → `R` → Type new name or path → `<Enter>` | Renames or moves the selected file.                    |
| **Open File**                     | Move to file → `<Enter>`                               | Opens the file in the current window.                  |
| **Open File in Vertical Split**   | Move to file → `v`                                     | Opens the file in a vertical split.                    |
| **Open File in Horizontal Split** | Move to file → `s`                                     | Opens the file in a horizontal split.                  |
| **Open File in New Tab**          | Move to file → `t`                                     | Opens the file in a new tab.                           |

---

### **Folder (Directory) Actions**

| **Action**                | **Command**                                              | **Description**                                 |
| ------------------------- | -------------------------------------------------------- | ----------------------------------------------- |
| **Create New Folder**     | `d` → Type folder name → `<Enter>`                       | Prompts to create a new directory.              |
| **Delete Folder**         | Move to folder → `D` → Confirm with `y`                  | Deletes the selected folder after confirmation. |
| **Rename or Move Folder** | Move to folder → `R` → Type new name or path → `<Enter>` | Renames or moves the selected folder.           |
| **Move Up a Directory**   | `-` or `h`                                               | Moves to the parent directory.                  |
| **Refresh Netrw Listing** | `R`                                                      | Reloads the current directory listing.          |

---

### **Other Features and Useful Commands**

| **Action**                  | **Command** | **Description**                                         |
| --------------------------- | ----------- | ------------------------------------------------------- |
| **Open Previous Directory** | `u`         | Goes back to the previously visited directory.          |
| **Close Netrw Buffer**      | `q`         | Exits Netrw and returns to the previous buffer.         |
| **Toggle Hidden Files**     | `X`         | Toggles the display of hidden files and directories.    |
| **Sort by File Type**       | `s`         | Sorts the files by type.                                |
| **Filter Files by Pattern** | `/pattern`  | Filters files using a search pattern.                   |
| **Preview File**            | `p`         | Previews the selected file (opens in a preview window). |
| **Execute Shell Command**   | `!command`  | Runs a shell command from within Netrw.                 |

---

## **Additional Tips**

1. **Navigating Faster**: Use arrow keys, `j`/`k` to move through files, and
   `/` to search within the directory.
2. **Moving Files and Folders**: When using `R`, you can **move files/folders**
   by typing a **new path** instead of just a new name.
3. **Refresh the Listing**: After making changes outside Netrw (like from the
   terminal), press `R` to **reload** the directory view.

---

## **Conclusion**

With these commands, you can efficiently manage files and directories directly
within **Neovim** using Netrw, avoiding the need for external plugins. You can
quickly create, delete, rename, and move files or directories, as well as open
them in splits or tabs.

This table serves as a quick reference for all essential actions available in
Netrw.

In **Neovim’s Netrw**, you can’t directly rename or create new directories
using **buffer-style editing**, but there are **efficient tricks** you can use
with **yank, paste, and renaming** that feel close to using **native Neovim
keybindings**.

Here’s how you can use **Neovim commands** in combination with **Netrw** to
achieve a smoother workflow for **creating, renaming, and copying files or
directories**.

---

## **1. Use `y` and `p` to Copy and Create New Files/Directories**

You can **yank and paste** file or directory names just like in **buffers** using the following workflow:

1. **Yank the Name:**

   - In **Netrw**, move to the file or folder you want to copy.
   - Press **`yy`** to **yank** the file or directory name.

2. **Create a New File/Directory Using the Yanked Name:**

   - Press **`%`** to create a **new file** or **`d`** to create a **new directory**.
   - In the prompt, **paste** the yanked name with `<C-r>"` (Ctrl + r followed by `"` to paste from the default register).

3. **Modify the Name (Optional):**
   - You can **edit the pasted name** if needed before pressing `<Enter>` to finalize the new file or directory.

---

## **2. Rename Files or Directories with `R`**

In **Netrw**, renaming is straightforward:

1. **Move to the File/Directory** you want to rename.
2. **Press `R`**: This will open a **rename prompt**.
3. **Modify the name** directly in the prompt and press `<Enter>` to confirm.

If you **yanked** a name earlier (using **`yy`**), you can **paste it** in the rename prompt with `<C-r>"`.

---

## **3. Using Registers for Smarter Naming and Copying**

Neovim’s **register system** allows you to **yank** and **reuse names** easily:

- **Yank to a Specific Register**:

  ```vim
  "ayy
  ```

  This yanks the name of the current file to register **`a`**.

- **Paste from Register in Netrw**:
  Use **`<C-r>a`** inside the **create or rename prompt** to paste the yanked name from register **`a`**.

---

## **4. Example Workflow: Copy and Rename a Directory**

1. Move to the directory you want to **copy**.
2. Press **`yy`** to yank the name.
3. Move to the location where you want to **create a new directory**.
4. Press **`d`** to create a new directory.
5. In the prompt, press **`<C-r>"`** to paste the yanked name.
6. **Modify the pasted name** if needed and press `<Enter>`.

---

## **Summary Table of Key Actions**

| **Action**                  | **Keybinding / Command** | **Description**                                            |
| --------------------------- | ------------------------ | ---------------------------------------------------------- |
| Yank File/Directory Name    | `yy`                     | Yanks the current item’s name into the default register.   |
| Paste Yanked Name           | `<C-r>"` in prompt       | Pastes the yanked name in a prompt (file creation/rename). |
| Create New File             | `%`                      | Opens a prompt to create a new file with a given name.     |
| Create New Directory        | `d`                      | Opens a prompt to create a new directory.                  |
| Rename File/Directory       | `R`                      | Opens a rename prompt for the selected item.               |
| Open File in Current Buffer | `<Enter>`                | Opens the file in the current buffer.                      |
| Delete File/Directory       | `D`                      | Deletes the selected file or directory with confirmation.  |

---

## **Conclusion**

While Netrw doesn’t support **buffer-style inline renaming**, you can use
**yanking, pasting, and registers** effectively to manage files and directories
smoothly. With **`R`** for renaming and **`yy`/`<C-r>"`** for copying and
creating, you can recreate a **familiar buffer-editing workflow**.

These techniques make Netrw a powerful file manager without requiring any
plugins, giving you fast and efficient ways to manage your files within Neovim.
Let me know if this helps or if you have further questions!


