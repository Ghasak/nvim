# Tips and Tricks in Nvim movements

<!-- vim-markdown-toc GitLab -->

* [Norm command](#norm-command)
    * [Adding to end or beginning of lines](#adding-to-end-or-beginning-of-lines)
    * [Executing CLI commands (from LINUX)](#executing-cli-commands-from-linux)
    * [Form multi-lines into one-line single line in vim](#form-multi-lines-into-one-line-single-line-in-vim)
    * [Do the opposite, form one-line to multi-lines](#do-the-opposite-form-one-line-to-multi-lines)
* [What the meaning of visual-mode](#what-the-meaning-of-visual-mode)
    * [Macro Recordings](#macro-recordings)
    * [Buffers](#buffers)
* [Open Website from nvim, or go to file](#open-website-from-nvim-or-go-to-file)
* [Encrypting files with :X](#encrypting-files-with-x)
    * [Auto-complete](#auto-complete)
    * [How to capitalize and deCapitalize in NeoVim](#how-to-capitalize-and-decapitalize-in-neovim)
    * [Table mode in nvim](#table-mode-in-nvim)
        * [How it works](#how-it-works)
        * [Align a Table fast](#align-a-table-fast)
* [Spell Checking](#spell-checking)
* [Arithmetic Expression](#arithmetic-expression)
    * [Increment and decrements](#increment-and-decrements)
    * [Execution commands](#execution-commands)
    * [Combine Commands](#combine-commands)
* [How to increment a list (most elegant way)](#how-to-increment-a-list-most-elegant-way)
    * [More example](#more-example)
* [How to capitalize first letter in many lines](#how-to-capitalize-first-letter-in-many-lines)
* [How to select or append from position to end of multi-lines](#how-to-select-or-append-from-position-to-end-of-multi-lines)
* [How to set a buffer to follow a certain language](#how-to-set-a-buffer-to-follow-a-certain-language)
* [VISUAL KEYBINDING](#visual-keybinding)

<!-- vim-markdown-toc -->

## Norm command

`normal` or `norm` can be used with a lot of features.

### Adding to end or beginning of lines

NOTE: (Read entry 47 in the table commands above for our daily shortcuts)
The following trick allow us to write to the end of lines or beginning of lines
Simply you can use the following.

1. Highlight all the lines using _shift + v_ then use _:_ to get: :`<,`>.
2. Adding `normal` or `norm` to the formula.
3. Adding to end you can use _A_ to the beginning add _I_.
4. Add your text to the end.

```sh
:`<,`>norm A whatever you will add to end of all lines.
:`<,`>norm I whatever you will add to beginning of all lines.
:`<,`>norm $X this  will delete last character at the end.
:`<,`>norm ^X this  will delete first character at the end.
```

- for example to insert "ABC" at the begining of each line:

```sh
Go to command mode
% norm I ABC
```

### Executing CLI commands (from LINUX)

We can use the following `:!command` that will be show the command with input and output

```sh
# This command will be used to sort alot of lines uniquly
:`<,`>! sort # for sorting
:`<,`>! wc -l  # for count number of lines
```

### Form multi-lines into one-line single line in vim

You can first select using `shift+v` for horizontal selection, to select all the lines you have
Then

```sh
:'<,'>j
```

or you can use
`g + shift +j` g command means only hits `g` letter to trigger the vim function for this purpose

### Do the opposite, form one-line to multi-lines

For sure we can do the opposite using, you can select the maximum number of your given string in oneline

```sh
:set textwidth=10
then use
g then q
dont forget to reset after you finish
:set textwidth=0
```

- [Vim Tutorial - Join and Split Lines](https://www.youtube.com/watch?v=MA9WFO_WUOM)

## What the meaning of visual-mode

`v` :is selecting visually a segment of a a given line.
`shift v` :is selecting visually multi-lines horizontally
`ctrl v` :si selecting visually multi-lines vertically.

### Macro Recordings

Recording is just using the `Macros` in `Nvim`, this need to study more about
this feature and to be added here later.

- Press `q + a`.
- Do the sub-task.
- Close macro `q`
- Apply the macro using `@a` or `@a 12` will be repeated 12 times.

### Buffers

You can use the following commands `:bnext`, `:bprevious` `buffers`, `bd` and `:enew` which
allow us to work with buffers more accurately.

## Open Website from nvim, or go to file

the command `g` stand for `G-command` one of the features that I like is `gx`
will open the link while the cursor on it in the browser. Open files / URLs with gf / gx

## Encrypting files with :X

[this feature available only for `Vim`, and it is not available for `nvim`, We
can add encryption to our file and only can be opened using the password we
have offer

1. to Encrypt

```sh
:X
```

It will allow to encrypt your file after you input and confirm your password for this file.

2. To decryPt
   do same without passwords by hitting enter + enter

### Auto-complete

Editing `auto comoplete` can you use `Ctrl + p` or `Ctrl + n`

### How to capitalize and deCapitalize in NeoVim

```sh
Using the keybinding
g + u : for first letter capitalize (change upper to lower, you need to do that on the letter you want to change then escape then l or h only once)
g + U : for capitalize all the letters (change upper to upper, you need to do that on the letter you want to change then escape then l or h only once)
g + ~ : to switch between the capitlal to small letter and viceversa (you will need shift to get the telda)

bonus
g + U 3 w will do for 3 words a head and captilze each word.
```

- [10 Advanced Vim Features You probably didn't know](https://www.youtube.com/watch?v=gccGjwTZA7k)

### Table mode in nvim

Using a plugin `vim-table-mode` to create a nice table, need to remember the following

- <leader> tm => is the trigger to the table in markdown format (\*.md)

#### How it works

1. Enter the first line, separating columns using the pipe symbol. The plugin
   responds by inserting spaces between the text and the separator if they are
   omitted:

```sh
| name | address | phone |
```

2. In the second line, type "||" twice to create a properly formatted
   horizontal line.

```sh
| name | address | phone |
|------+---------+-------|
```

3. When you type in the subsequent lines, the plugin will automatically adjust
   its formatting to match the text that you're typing each time you press "|".

| name                        | address             | phone                                          |
| --------------------------- | ------------------- | ---------------------------------------------- |
| Formulate the address first | For on the idea for | Create the right table in material_design_dark |
| This could                  | How about the       | Working on the second objectives               |

#### Align a Table fast

The follow trick require the plugin `align.nvim` and `vim-table-mode`.

1. Assume you have the following table

```sh
BufNewFile	starting to edit a file that doesnt exist
BufReadPre	starting to edit a new buffer, before reading the file
BufRead	starting to edit a new buffer, after reading the file
BufReadPost	starting to edit a new buffer, after reading the file
BufReadCmd	before starting to edit a new buffer Cmd-event
FileReadPre	before reading a file with a ":read" command
FileReadPost	after reading a file with a ":read" command
```

2. First align to `space` using regular expression `align.nvim` is used `ar`
   keybinding in visual mode.

   - Highlight in visual mode all the text
   - Use `ar` then `:\s` in cmdline.

```sh
BufNewFile  	starting to edit a file that doesnt exist
BufReadPre  	starting to edit a new buffer, before reading the file
FileReadPre 	before reading a file with a ":read" command
FileReadPost	after reading a file with a ":read" command
```

3. Now, ensure the table mode is on using `<leader>tm`.
   - Put the cursor at the begning of the lines
   - create in vertical visual mode `v` only to add `|` the pipe line.

```sh
| BufNewFile  |	starting to edit a file that doesnt exist
| BufReadPre  |	starting to edit a new buffer, before reading the file
| FileReadPre |	before reading a file with a ":read" command
| FileReadPost|	after reading a file with a ":read" command

```

4. Now, select the second portion of the table using `v` visual mode - vertical
   visual selection.
   - Select all lines after highlighting in vertical visual mode using `$`
     keybinding
   - Adding a `|` at the end of each line can be done using `:'<,'>normal A |`

```sh
| BufNewFile  |	starting to edit a file that doesnt exist |
| BufReadPre  |	starting to edit a new buffer, before reading the file |
| FileReadPre |	before reading a file with a ":read" command |
| FileReadPost|	after reading a file with a ":read" command |

```

5. Now it shoud align automatically if you have `table` plugin turn on. If not
   then you can again perform the `ar` of the portion of right side of the
   table. After we can add the `(-)` with double `|` to the second line.

```sh

| BufNewFile     | starting to edit a file that does not exist              |
| -------------- | -------------------------------------------------------- |
| BufReadPre     | starting to edit a new buffer, before reading the file   |
| FileReadPre    | before reading a file with a ":read" command             |
| FileReadPost   | after reading a file with a ":read" command              |

```

- Check out the [Align natively in Vim](https://vim.fandom.com/wiki/Regex-based_text_alignment) page, for more details.

## Spell Checking

you can use `z=` once your cursor is on top of the wrong-spelling word, which
will give you a list of all the possible options to fix the wrong spelling.
To add a word to the custom dictionary use `zg` over the new word (e.g., treeSitter)
it will be added to `~/.config/nvim/spell/en.utf-8.add`.

## Arithmetic Expression

### Increment and decrements

You can basically do arithmetic in `nvim` such as

- increment and decrements an integer value using `ctrl + a` or `ctrl +x` over the number (e.g., 144)
  Using it with number increment list with `macro`

1. Record a macro using `q+a`
2. make a line with a number then copy it for next line
3. increment the number of the list using `ctrl+a`
4. finish recording the macro with `q`
5. repeat the macro using `@a` or `@a 3` to repeat it three times

### Execution commands

- Put the cursor over the following expression in a **new line** (must be at
  the begging of the line to make it works):

```
echo $((100 + 54))
```

- You can execute a command in your `nvim buffer` using `:.!zsh` to redraw your
  command line and get you the results inside the buffer.
- You can execute a command in your `nvim command palette` with `:!!zsh`

### Combine Commands

1. Hello world
2. Hello world
3. Hello world
4. Hello world
5. Hello world
6. Hello world
7. Hello world

- Assume we have the text above. highlight all these lines
- use :`<,`>s/\..\+//cig
- It will get you all the numbers
  1
  2
  3
  4
  5
  6
  7
- Highlight again and use `<,`>norm A + to add (+) to the end of each line
  1 +
  2 +
  3 +
  4 +
  5 +
  6 +
  7 +

- Highlight again and use `<,`>join (or simply j) to join them all together.
  1 + 2 + 3 + 4 + 5 + 6 + 7 +
- Finally get the value of this expression using `:.!zsh` as:
  echo $((1 + 2 + 3 + 4 + 5 + 6 + 7))

- Now we can get the final value as
  28

## How to increment a list (most elegant way)

We can use the following steps:

- Create a list with zeros as shown using `ctrl+v` then `shit + i` then `0` and enter.

```sh
- [0] list number 1
- [0] list number 1
- [0] list number 1
- [0] list number 1
```

- Now you highlight `visual block` using `<C-v>` also knows as `ctrl+v` again the list at `0` and perform `g<C-a>`

```sh
- [1] list number 1
- [2] list number 2
- [3] list number 3
- [4] list number 4

```

- [Quick vim tips to generate and increment numbers](https://irian.to/blogs/quick-vim-tips-to-generate-and-increment-numbers/)

### More example

1. Try to put some text with increment

```sh
:for i in range(1,10) | put ='192.168.0.'.i | endfor
```

2. Try to create counter with 00 prefixes

```sh
:put =map(range(1,150), 'printf(''%04d'', v:val)')
```

- [More tips and tricks about increments](https://vim.fandom.com/wiki/Making_a_list_of_numbers)

## How to capitalize first letter in many lines

- [my comment can be found here](https://stackoverflow.com/questions/3126500/how-do-i-capitalize-the-first-letter-of-a-word-in-vim/72860055#728600550)
- [10 Advanced Vim Features You probably didn't know](https://www.youtube.com/watch?v=gccGjwTZA7k)
- [dotfile](https://github.com/sdaschner/dotfiles/blob/master/.vimrc)

## How to select or append from position to end of multi-lines

1. Click somewhere (anywhere) in the first line you wish to append text to.
2. Press Control + V.
3. Press Down to create an arbitrary vertical block selection that spans the desired lines.
4. Press $ to expand the visual block selection to the ends of every line selected.
5. Press Shift + A to append text to every selected line.
6. Type the text you want to append.
7. Press Escape and the text will be appended across the selected lines.

- [Vim Select the ends of multiple lines block mode ](https://stackoverflow.com/questions/10772598/vim-select-the-ends-of-multiple-lines-block-mode-but-where-the-ending-column-v)

## How to set a buffer to follow a certain language

- Once you are inside an undefine buffer (e.g., .spacemacs config file) , you
  can say its following `lisp`, so you can use `:setfiletype lisp`
  - Following the form `:setfiletype \<file_type\> `| Select to open given
    unknown file with treesitter similar to a given file |

## VISUAL KEYBINDING

There are so many keybindings for the nvim in the visual model that are native
and can greatly enhance your workflow. For example:

1. While selecting a block in visual mode, you can use "o" to switch the cursor
   position of handling movement.
2. Selecting `w` will highlight the given word of each line

```html
<body>
  <h3>Best Webpage ever!</h3>
  <div>
    <Span> what we can assume here ->
    <Span> what we can assume here ->
    <span>Something</span>
</body>
```
