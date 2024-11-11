# Yank with Register

We have a register in `Vim` as a temporary storage, which can be used to store
values and refer back to them as needed. Here are some commonly useful
applications for this feature during typical workflows:

## 1. Copy and paste from register

`yanking`, `deleting`, `modifying` text we have about 26 register to store [a-z],

1. `"a` then `yank`, `delete` or any action.
   It will be store in regsiter `a`, you can do this for any register such as `"b`, `"c`...etc.

2. You can now `:reg` or `:register`, which will give us the right way to make things more clear.
   You can also use `Telescope registers`, this will allow you to check all the registers
   You can also check specific register using `:reg ab`
3. To paste any regsiter you can use `"a`, `"b`, then `p` , it will allow to
   pate from what is stored in this register.

- **Note**: to yank several lines and store them to register it is always
- For example to store a given function into register a
  `visutal => "a => y `
- You can delete several items and they will be stored autoamtically in
  regsiters `1`, `2`, `3` ..etc.

## 2. Macro useful case

1. For macro we record a macro as usual using `q` and pick a register such as
   `a`.
2. then the list of keys that we wish to modify
3. assume you made an error with some keys or want to store this macro for
   later session using.
4. Now you can use in an open buffer temporary such as using `:new buffer`,
   check all opened buffer using `:buffers`.
5. then in command line use `:put register_name` such as `:put a`
6. Now, you can modify it as you want.
7. save it to a given register such as same one we have `a`. In normal mode
   `"ayy` yank the line of the macro in the opened temp buffer.

## 3. With S or G replace

1. Assume you yanked the first word to register a.
2. Assume you yanked the second word to register b.
3. Now, when you select all the lines that you want to replace with `vip`, and now use:

```sh


                    `'<,'>s/first_word/second_word` patter
                           ──────┬─── ────┬──────
                                 │        │
                        ┌────────┘        └────▶ use `ctr r` b
                        │
                        ▼
                    use `ctrl r`a



```

## References

- [Working with Vim Registers | Copy and Paste Better](https://www.youtube.com/watch?v=QVvrkwipr8g&t=1s&ab_channel=matt-savvy)
- [Delete Without Copying in Vim](https://www.youtube.com/watch?v=cjNtDVmzr5A&ab_channel=NirLichtman)
- [This VIM trick below my mind](https://www.youtube.com/watch?v=bTmEqmtr_6I&ab_channel=typecraft)
