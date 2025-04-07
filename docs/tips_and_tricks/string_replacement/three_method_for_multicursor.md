# THREE METHODS FOR MULTICURSORS

Assume we have a list of items that we wish to add something to it at the begging and end of these items.

- Also these items are with different lenght and with multiple spaces in between ..etc.
- All these methods are native and work for `vim ` and `nvim`.
- Assume you want to create a tag for the following list in `html`.

```sh
┌────────────┐                     ┌─────────────────┐
│banana      │                     │<b>banana</b>    │
│oranges     │                     │<b>oranges</b>   │
│apple       │                     │<b>apple</b>     │
│fig         │ ─────────────────▶  │<b>fig</b>       │
│kiwi        │                     │<b>kiwi</b>      │
│melon       │                     │<b>melon</b>     │
│watermelon  │                     │<b>watermelon</b>│
│grape       │                     │<b>grape</b>     │
└────────────┘                     └─────────────────┘
```

## Method -1, Native vim

### Left tag \<b\>

1. `Ctrl + v` for lines with selecting all possible line in visual mode.
2. `shfit + i` to go to insert mode and then write `\<b\>` the tag for the left side.
3. Hit enter to get the resut you want

### Right tag \<\/b\>

1. Select last visual selection usign `gv` which is from the prvoius operation will select all the lines at their beginning.
2. Use `$` to highlight all lines in `visual-block` up to the end of all lines.
3. Use `shift a` to append to the end of all lines and write the closing tag , with `Esc` you will get the results you want.

- [Vim motion & Tricks](https://www.youtube.com/watch?v=RdyfT2dbt78&ab_channel=HenryMisc)

## Method -2 Using cmdline

Same like the one above but we use for the left tag

1. Select all the lines you want to append to end using `vip` visualize inside a paragraph.

2. Now, you can use the cmd-line with `'<,'>normal A</b>` as for appending with cmdline.

## Method -3 Using s or g command replace

1. We select the all paragraph
2. We use the s// patter matching, I applied `'<,'>s/\v(\w+)/\1<\/b\>`
   - \v for making the regular expression much easy to be handled.
   - \w+ select word
   - \1 get what you have stored in the bracket usign `(\w+)`

