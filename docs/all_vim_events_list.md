# List of All Events in Vim/Nvim

<!-- vim-markdown-toc GitLab -->

* [Reading](#reading)
* [Writing](#writing)
* [Buffers](#buffers)
* [Options](#options)
* [Startup and exit](#startup-and-exit)
* [Various](#various)
* [Reference](#reference)

<!-- vim-markdown-toc -->

To get an idea of what Vimscript is capable of, take a look at all the events
it can react to because basically your script won't do much except when
something happens (usually caused by the user) and your script reacts. For
example, do something when opening a file, or highlighting a word, or hitting
some trigger key.

- You don't want your script to just be running constantly in a
  loop in the background, and you also don't want it to stall Vim during its
  handling of events, including at startup.

- If you go through Vim's built-in documentation you can find the list of
  events but I've created some tables to make it easier to view online.

- You've probably noticed these before in other people's VIm scripts or in
  .vimrc lines you've copied and pasted (the Buf\* events like BufRead or
  BufWrite are common). First an overview by function with a short explanation.
  Then the list alphabetically with full explanations autocmd-events-abc.

## Reading

| Event          | Description                                            |
| -------------- | ------------------------------------------------------ |
| BufNewFile     | starting to edit a file that doesn't exist             |
| BufReadPre     | starting to edit a new buffer, before reading the file |
| BufRead        | starting to edit a new buffer, after reading the file  |
| BufReadPost    | starting to edit a new buffer, after reading the file  |
| BufReadCmd     | before starting to edit a new buffer Cmd-event         |
| FileReadPre    | before reading a file with a ":read" command           |
| FileReadPost   | after reading a file with a ":read" command            |
| FileReadCmd    | before reading a file with a ":read" command Cmd-event |
| FilterReadPre  | before reading a file from a filter command            |
| FilterReadPost | after reading a file from a filter command             |
| StdinReadPre   | before reading from stdin into the buffer              |
| StdinReadPost  | After reading from the stdin into the buffer           |

## Writing

| Event           | Description                                           |
| --------------- | ----------------------------------------------------- |
| BufWrite        | starting to write the whole buffer to a file          |
| BufWritePre     | starting to write the whole buffer to a file          |
| BufWritePost    | after writing the whole buffer to a file              |
| BufWriteCmd     | before writing the whole buffer to a file Cmd-event   |
| FileWritePre    | starting to write part of a buffer to a file          |
| FileWritePost   | after writing part of a buffer to a file              |
| FileWriteCmd    | before writing part of a buffer to a file Cmd-event   |
| FileAppendPre   | starting to append to a file                          |
| FileAppendPost  | after appending to a file                             |
| FileAppendCmd   | before appending to a file Cmd-event                  |
| FilterWritePre  | starting to write a file for a filter command or diff |
| FilterWritePost | after writing a file for a filter command or diff     |

## Buffers

| Event       | Description                                    |
| ----------- | ---------------------------------------------- |
| BufAdd      | just after adding a buffer to the buffer list  |
| BufCreate   | just after adding a buffer to the buffer list  |
| BufDelete   | before deleting a buffer from the buffer list  |
| BufWipeout  | before completely deleting a buffer            |
| BufFilePre  | before changing the name of the current buffer |
| BufFilePost | after changing the name of the current buffer  |
| BufEnter    | after entering a buffer                        |
| BufLeave    | before leaving to another buffer               |
| BufWinEnter | after a buffer is displayed in a window        |
| BufWinLeave | before a buffer is removed from a window       |
| BufUnload   | before unloading a buffer                      |
| BufHidden   | just after a buffer has become hidden          |
| BufNew      | just after creating a new buffer               |
| SwapExists  | detected an existing swap file                 |

## Options

| Event           | Description                                  |
| --------------- | -------------------------------------------- |
| FileType        | when the 'filetype' option has been set      |
| Syntax          | when the 'syntax' option has been set        |
| EncodingChanged | after the 'encoding' option has been changed |
| TermChanged     | after the value of 'term' has changed        |

## Startup and exit

| Event        | Description                                         |
| ------------ | --------------------------------------------------- |
| VimEnter     | after doing all the startup stuff                   |
| GUIEnter     | after starting the GUI successfully                 |
| GUIFailed    | after starting the GUI failed                       |
| TermResponse | after the terminal response to t_RV is received     |
| QuitPre      | when using :quit, before deciding whether to quit   |
| VimLeavePre  | before exiting Vim, before writing the viminfo file |
| VimLeave     | before exiting Vim, after writing the viminfo file  |

## Various

| Event                | Description                                                    |
| -------------------- | -------------------------------------------------------------- |
| FileChangedShell     | Vim notices that a file changed since editing started          |
| FileChangedShellPost | After handling a file changed since editing started            |
| FileChangedRO        | before making the first change to a read-only file             |
| ShellCmdPost         | after executing a shell command                                |
| ShellFilterPost      | after filtering with a shell command                           |
| FuncUndefined        | a user function is used but it isn't defined                   |
| SpellFileMissing     | a spell file is used but it can't be found                     |
| SourcePre            | before sourcing a Vim script                                   |
| SourceCmd            | before sourcing a Vim script Cmd-event                         |
| VimResized           | after the Vim window size changed                              |
| FocusGained          | Vim got input focus                                            |
| FocusLost            | Vim lost input focus                                           |
| CursorHold           | the user doesn't press a key for a while                       |
| CursorHoldI          | the user doesn't press a key for a while in Insert mode        |
| CursorMoved          | the cursor was moved in Normal mode                            |
| CursorMovedI         | the cursor was moved in Insert mode                            |
| WinEnter             | after entering another window                                  |
| WinLeave             | before leaving a window                                        |
| TabEnter             | after entering another tab page                                |
| TabLeave             | before leaving a tab page                                      |
| CmdwinEnter          | after entering the command-line window                         |
| CmdwinLeave          | before leaving the command-line window                         |
| InsertEnter          | starting Insert mode                                           |
| InsertChange         | when typing while in Insert or Replace mode                    |
| InsertLeave          | when leaving Insert mode                                       |
| InsertCharPre        | when a character was typed in Insert mode, before inserting it |
| TextChanged          | after a change was made to the text in Normal mode             |
| TextChangedI         | after a change was made to the text in Insert mode             |
| ColorScheme          | after loading a color scheme                                   |
| RemoteReply          | a reply from a server Vim was received                         |
| QuickFixCmdPre       | before a quickfix command is run                               |
| QuickFixCmdPost      | after a quickfix command is run                                |
| SessionLoadPost      | after loading a session file                                   |
| MenuPopup            | just before showing the popup menu                             |
| CompleteDone         | after Insert mode completion is done                           |
| User                 | to be used in combination with ":doautocmd"                    |

## Reference

- [List of all Vim script events](https://tech.saigonist.com/b/code/list-all-vim-script-events.html)
