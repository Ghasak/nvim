# Performance Tricks in Neovim

<!-- vim-markdown-toc GitLab -->

* [Better surroundings](#better-surroundings)
* [Better replace with register](#better-replace-with-register)
* [Past inside a quote](#past-inside-a-quote)
* [Searching for multiple words](#searching-for-multiple-words)
* [Reference](#reference)

<!-- vim-markdown-toc -->

## Better surroundings

This plugin give us the ability to perform `surroundings` easily

```lua
   -- Better surrounding
   use({ "tpope/vim-surround",
    opt = true,
    event = "InsertEnter"
  })

```

- Rules:

2. To surroundings given word: `y`+`s`+`w` then `" or '`
3. To delete surroundings given word: `d`+`s`+ `" or '`
4. To change given surroundings : `c`+`s`+ `' or "`

- Very nice trick

```lua
-- How we can achieve that
use({dbeniamine/cheat.sh-vim}) => use({"dbeniamine/cheat.sh-vim"})

`y` + `s` + `i` + `{` + `"`

```

## Better replace with register

This plugin is used for replacing yanked word with support to the command (.)

```lua

  use({"vim-scripts/ReplaceWithRegister",
    opt = true,
    event = "InsertEnter"
  })
```

- For example use the following, to Replace with regsiter [you can yank a word
  then use <ESC>b then grw]. `b` means back to begning of a word.

```lua
vim.keymap.set("n", "gr", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "grl", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("n", "grv", "<Plug>ReplaceWithRegisterVisual")
```

## Past inside a quote

For "replace-inner-quotes-to-yanked-text" you can use `vi"p`

- Rules

2. To yank a word: `y`+`w`
3. To replace with a registered yanked word: `g`+`r`+`w`
4. Repeat the yanked word using `.`
5. Yanking a word without a white spaces `y` + `i` + `w`

## Searching for multiple words

There are two simple ways to highlight multiple words in vim editor.

1. Go to search mode i.e., type `/` and then type `\v` followed by the words
   you want to search separated by `|` (pipe).

```vim
/\vword1|word2|word3
```

2. Go to search mode and type the words you want to search separated by `|`

```vim
/word1\|word2\|word3
```

- Basically, the first puts you in the regular expression mode so that you do
  not need to put any extra back slashes before every pipe or other delimiters
  used for searching.

## Reference

- [How can replace string in quotes with string from buffer](https://stackoverflow.com/questions/4483743/how-can-replace-string-in-quotes-with-string-from-buffer)
- [Is there any way to highlight multiple words](https://stackoverflow.com/questions/704434/is-there-any-way-to-highlight-multiple-searches-in-gvim)
