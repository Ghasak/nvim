# Nvim-Tree Cheat Sheet

We can use the following cheat-sheet for possiblility of increasing productivity.

## Working with the File Explorer¶

To work with your project's file tree NvimTree provides a number of useful
shortcuts for its management, which are:

- `R` (refresh) to perform a reread of the files contained in the project
- `H` (hide) to hide/display hidden files and folders (beginning with a dot .)
- `E` (expand_all) to expand the entire file tree starting from the root folder (workspace)
- `W` (collapse_all) to close all open folders starting from the root folder
- `-`(dir_up) allows you to go back up folders. This navigation also allows you to exit the root folder (workspace) to your home directory
- `s`(system) to open the file with the system application set by default for that file type
- `f`(find) to open the interactive file search to which search filters can be applied
- `F`to close the interactive search
- `Ctrl + k` to display information about the file such as size, creation date, etc.
- `g + ?` to open the help with all the predefined shortcuts for quick reference
- `q` to close the file explorer

## Opening a File

Positioned in the desired folder and with the file selected to be edited, we
have the following combinations to open it:

- `Enter` o `o` to open the file in a new buffer and place the cursor on the
  first line of the file
- `Tab` to open the file in a new buffer while keeping the cursor in nvimtree,
  this for example is useful if you want to open several files at once
- `Ctrl + t` to open the file in a new tab that can be managed separately from
  the other buffers present
- `Ctrl + v` to open the file in the buffer by dividing it vertically into two
  parts, if there was already an open file this will be displayed side by side
  with the new file
- `Ctrl + h` to open the file like the command described above but dividing
  the buffer horizontally.

## File Management¶

Like all file explorers, in nvimtree you can create, delete, and rename files.
Since this is always with a textual approach, you will not have a convenient
graphical widget but the directions will be shown in the statusline. All
combinations have a confirmation prompt (y/n) to give a way to verify the
operation and thus avoid inappropriate changes. This is particularly important
for deletion of a file, as a deletion would be irreversible.

- The keys for modification are:

- `a` (add) allows the creation of files or folders, creating a folder is done
  by following the name with the slash /. E.g. /nvchad/nvimtree.md will create
  the related markdown file while /nvchad/nvimtree/ will create the nvimtree
  folder. The creation will occur by default at the location where the cursor
  is in the file explorer at that time, so the selection of the folder where to
  create the file will have to be done previously or alternatively you can
  write the full path in the statusline, in writing the path you can make use
  of the auto-complete function
- `r` (rename) to rename the selected file from the original name
- `Ctrl + r` to rename the file regardless of its original name
- `d` (delete) to delete the selected file or in case of a folder delete the
  folder with all its contents
- `x` (cut) to cut and copy the selection to the clipboard, can be files or
  folders with all its contents, with this command associated with the paste
  command you make the file moves within the tree
- `c` (copy) like the previous command this copies the file to the clipboard
  but keeps the original file in its location
- `p` (paste) to paste the contents of the clipboard to the current location
- `y` to copy only the file name to the clipboard, there are also two variants
  which are Y to copy the relative path and g + y to copy the absolute path

### References

- [Reference - Nvim-Tree Advanced keybinding ](https://docs.rockylinux.org/books/nvchad/nvchad_ui/nvimtree/)
