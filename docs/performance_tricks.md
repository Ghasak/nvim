# Performance Tricks in Neovim

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
2. To surroundings given word:      `y`+`s`+`w` then `" or '`
3. To delete surroundings given word:    `d`+`s`+ `" or '`
4. To change given surroundings :         `c`+`s`+ `' or "`


- Very nice trick

```lua
-- How we can achieve that
use({dbeniamine/cheat.sh-vim}) => use({"dbeniamine/cheat.sh-vim"})

`y` + `s` + `i` + `{` + `"`

```
## Better replace with reggister
This plugin is used for replacing yanked word with support to the command (.)
```lua

  use({"vim-scripts/ReplaceWithRegister",
    opt = true,
    event = "InsertEnter"
  })
```


## Past inside a quote
For "replace-inner-quotes-to-yanked-text" you can use `vi"p`

- Rules
2. To yank a word:   `y`+`w`
3. To replace with a registered yanked word:  `g`+`r`+`w`
4. Repeat the yanked word using `.`

## Reference
- [How can replace string in quotes with string from buffer](https://stackoverflow.com/questions/4483743/how-can-replace-string-in-quotes-with-string-from-buffer)
