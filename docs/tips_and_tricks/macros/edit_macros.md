# How to Edit an Existing Vim Macro

## Here’s the situation

You’ve just written an awesome vim macro and stopped recording. However, when
you try an run the macro you realize that you forgot to add a ^ to the
beginning of it and now it only works if you go back to the beginning of the
line before running it. You might be thinking that its time to re-record, but
there are two simple ways to edit an existing macro instead.

## Yanking into a register

- "qp paste the contents of the register to the current cursor position
- I enter insert mode at the begging of the pasted line
- ^ add the missing motion to return to the front of the line
- <Escape> return to visual mode
- "qyy yank this new modified macro back into the q register
- dd delete the pasted register from the file your editing

## Editing the register visually

- :let @q=' open the q register
- `<Cntl-r><Cntl-r>q` paste the contents of the q register into the buffer
- ^ add the missing motion to return to the front of the line
- ' add a closing quote
- <Enter> finish editing the macro

## What’s next

If you found this useful, you might also enjoy:

- [Vim Macros and You](https://thoughtbot.com/blog/vim-macros-and-you)
- [thoughtbot is filled with vim and vigor](https://thoughtbot.com/blog/thoughtbot-is-filled-with-vim-and-vigor)



