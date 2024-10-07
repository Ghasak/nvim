# Vim Movement cheatsheet

<!-- vim-markdown-toc GitLab -->

* [Introduction](#introduction)
* [VIM GRAMMER](#vim-grammer)
    * [Normal Mode](#normal-mode)
    * [Insert Mode](#insert-mode)
    * [Visual Mode](#visual-mode)
    * [Command-Line Mode](#command-line-mode)
    * [Visual Block Mode](#visual-block-mode)
    * [Ex Mode](#ex-mode)
* [Deleting](#deleting)
    * [Deleting diagram](#deleting-diagram)

<!-- vim-markdown-toc -->

## Introduction

Listing every single key and its functions across all modes in Vim is quite
extensive, but I'll give you an overview of some common keys and their uses in
Normal, Insert, and Visual modes:

## VIM GRAMMER

```sh
  +--------+     +-----------+     +--------+     +--------+
  | count  |---->| operator  |---->| count  |---->| motion |
  +--------+     +-----------+     +--------+     +--------+
      ^                ^               ^              ^
      |                |               |              |
      |                |               |              |
  Optional         Command         Optional      Movement
   Number of      to Perform       Number of    through Text
  Repetitions     (e.g., delete,   Repetitions   (e.g., word,
                  change, yank)                  end of line)


  +-------------------------------------------------------------------+
  |                          VIM COMMAND GRAMMAR                      |
  +-------------------------------------------------------------------+
  |                                                                   |
  |  [count][operator][count][motion]                                 |
  |                                                                   |
  |  Where:                                                           |
  |                                                                   |
  |  [count]   - (optional) Number of times to repeat the command     |
  |  [operator]- (optional) Command that specifies an operation,      |
  |              such as change (c), delete (d), yank (y), etc.       |
  |  [motion]  - Movement command that specifies over what the        |
  |              operator should be applied, such as word (w),        |
  |              to end of line ($), etc.                             |
  |                                                                   |
  |  Examples:                                                        |
  |                                                                   |
  |  d$      - Delete from cursor to the end of the line              |
  |  c3w     - Change the next three words                            |
  |  yG      - Yank from the current line to the end of the file      |
  |  2dd     - Delete 2 lines starting from the current line          |
  |                                                                   |
  +-------------------------------------------------------------------+
  |                                                                   |
  |  [count][command]                                                 |
  |                                                                   |
  |  Where:                                                           |
  |                                                                   |
  |  [count]   - (optional) Number of times to repeat the command     |
  |  [command] - Single-key command like (i)nsert, (a)ppend, etc.     |
  |                                                                   |
  |  Examples:                                                        |
  |                                                                   |
  |  5j      - Move down 5 lines                                      |
  |  3x      - Delete character under cursor 3 times                  |
  |  7iHello - Insert 'Hello' 7 times                                 |
  |                                                                   |
  +-------------------------------------------------------------------+

```

### Normal Mode

Normal mode is where you can run commands and navigate through the file.

| Key          | Function                              |
| ------------ | ------------------------------------- |
| `h`          | Move left                             |
| `j`          | Move down                             |
| `k`          | Move up                               |
| `l`          | Move right                            |
| `w`          | Jump forwards to the start of a word  |
| `b`          | Jump backwards to the start of a word |
| `e`          | Jump forwards to the end of a word    |
| `gg`         | Go to the first line of the document  |
| `G`          | Go to the last line of the document   |
| `dd`         | Delete the current line               |
| `yy`         | Yank (copy) the current line          |
| `p`          | Paste the clipboard after the cursor  |
| `P`          | Paste the clipboard before the cursor |
| `u`          | Undo the last operation               |
| `Ctrl` + `r` | Redo the last undo                    |

### Insert Mode

Insert mode is for editing and inserting text.

| Key          | Function                                  |
| ------------ | ----------------------------------------- |
| `ESC`        | Return to Normal mode                     |
| `Ctrl` + `h` | Delete the character to the left          |
| `Ctrl` + `w` | Delete the word to the left               |
| `Ctrl` + `o` | Temporarily perform a Normal mode command |

### Visual Mode

Visual mode is for selecting text to operate on.

| Key          | Function                                |
| ------------ | --------------------------------------- |
| `v`          | Start Visual mode (character selection) |
| `V`          | Start Visual mode (line selection)      |
| `Ctrl` + `v` | Start Visual Block mode                 |
| `o`          | Move to other end of highlighted text   |
| `d`          | Delete highlighted text                 |
| `y`          | Yank (copy) highlighted text            |
| `>`          | Shift text right                        |
| `<`          | Shift text left                         |

### Command-Line Mode

Command-line mode is where you can enter commands that you can't run from Normal mode.

| Key | Function                                |
| --- | --------------------------------------- |
| `:` | Enter Command-line mode                 |
| `/` | Search forwards                         |
| `?` | Search backwards                        |
| `n` | Repeat search in the same direction     |
| `N` | Repeat search in the opposite direction |

### Visual Block Mode

A variant of Visual mode for selecting blocks of text.

| Key | Function                |
| --- | ----------------------- |
| `I` | Insert before the block |
| `A` | Append after the block  |
| `d` | Delete the block        |
| `y` | Yank (copy) the block   |
| `p` | Paste after the block   |

### Ex Mode

A mode where you can enter multiple-line commands.

| Key   | Function                           |
| ----- | ---------------------------------- |
| `Q`   | Enter Ex mode                      |
| `:vi` | Return to Normal mode from Ex mode |

These are just a few of the keys and their functions in Vim. Vim also allows
for extensive customization and creation of new commands and key bindings via
its scripting language, Vimscript. Furthermore, there are many plugins
available for Vim that can add new functionalities and key bindings.

             ^
             k              Hint:  The h key is at the left and moves left.
       < h       l >               The l key is at the right and moves right.
             j                     The j key looks like a down arrow.
             v

## Deleting

1. Delete from beginning of line with empty spaces

- Put the cursor at the `t` in the word `to`, now use `d0`

```vim
sometest                                   to another test section
                                           ^

# Result

to another test section
```

2. Delete from beginning of line with empty spaces.

- Put the curosr at the beginning of the line, and use `d^`

```vim
                                 to another test section
^

# Result
to another test section

```

### Deleting diagram

Creating an ASCII diagram with arrows pointing in different directions to
represent all possible delete operations in Vim is a bit challenging due to the
limitations of text representation, but here's a simple diagram that attempts
to show some of the fundamental delete commands in Vim:

```sh
                         +---+
                         | k |
                         | ^ |
                         | | | (up) Delete line upwards (dk)
+---------+   +---------+---+---------+   +---------+
| b       |   | ^       | d |       $ |   | w       |
| <-------+---+ |       +---+       | +---+-------> |
| (back)  |   | |       Delete     | |   | (forward)|
| Delete  |   | |       at cursor  | |   | Delete   |
| word    |   | |       (x or dl)  | |   | word     |
| backwards(dbb)|       | +---------+   | (dw)      |
+---------+   | |       | d0            +---------+
              | |       +---+
              | +---------+ |
              | Delete till| |
+---------+   | beginning  | |   +---------+
|         |<--+ of line    | +-->|         |
| dgg     |   | (d^)       |     | dG      |
| Delete  |   +------------+     | Delete  |
| to top  |                       | to bottom|
+---------+                       +---------+
    (up)                             (down)
```

In this diagram:

- `d` is the delete operator in Vim and is combined with various motions to
  delete in different directions and scopes.
- `x` or `dl` deletes the character at the cursor (similar to pressing `Delete`
  in other text editors).
- `d0` or `d^` deletes from the current cursor position to the beginning of the
  line.
- `d$` deletes from the cursor to the end of the line.
- `dw` deletes from the cursor to the end of the current word.
- `db` or `dbb` deletes from the cursor to the beginning of the current word.
- `dk` deletes the line above the cursor and the line the cursor is on.
- `dj` deletes the line the cursor is on and the line below.
- `dgg` deletes from the current line to the top of the file.
- `dG` deletes from the current line to the bottom of the file.
