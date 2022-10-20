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



## Better replace with reggister
This plugin is used for replacing yanked word with support to the command (.)
```lua

  use({"vim-scripts/ReplaceWithRegister",
    opt = true,
    event = "InsertEnter"
  })
```

- Rules
2. To yank a word:   `y`+`w`
3. To replace with a registered yanked word:  `g`+`r`+`w`
4. Repeat the yanked word using `.`




