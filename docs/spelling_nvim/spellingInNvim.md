# Spelling in Nvim in action

Spelling in action based on the plugin `blink-cmp-dictionary` which can be found here:

- [blink-cmp-dictionary](https://github.com/Kaiser-Yang/blink-cmp-dictionary?tab=readme-ov-file)

The magic of this extension lies in its integration with the `blink.nvim`
plugin, which allows for on-the-fly spelling checks with definitions. All
current dictionaries are created from text files containing sorted words. There
is also a tool called `wordnet` that can provide definitions for English words
as you type. It can be installed via

```sh
╰─ brew install wordnet                                                                                                                               ─╯
```

## English words

For a dictionary I use `english-words` along with the `wordnet` for the defintion.

- A text file containing 479k English words for all your dictionary/word-based
  projects e.g: auto-completion / autosuggestion
  - [English-word](https://github.com/dwyl/english-words)
-

## Preperation

You’re seeing those garbled “���” and trailing `^M` marks because the Google
IME dict comes in a Windows‐style Japanese encoding (Shift-JIS / CP932) with
CRLF line endings. Blink-cmp-dictionary expects a clean UTF-8 file. Here’s how
to fix it:

---

### 1. Figure out the source encoding (optional)

```bash
file -I EnglishIMEdict_en2-0L.txt
# or
enca -L none EnglishIMEdict_en2-0L.txt
```

You’ll probably see `charset=iso-2022-jp` or `charset=shift_jis`.

---

### 2. Convert to UTF-8 and strip CRLF in one go

```bash
# install dos2unix if you don’t have it
brew install dos2unix

# convert Shift-JIS → UTF-8 and fix line endings
iconv -f CP932 -t UTF-8 EnglishIMEdict_en2-0L.txt \
  | dos2unix \
  > ~/.config/nvim/dicts/EnglishIMEdict_en2-0L.utf8.txt
```

- `-f CP932` tells iconv the input is Windows-style Japanese.
- `-t UTF-8` makes the output UTF-8.
- `dos2unix` removes the `\r` so you don’t get `^M` in vim.

---

### 3. (Alternative) Do it inside Neovim

```vim
:e ++enc=cp932 EnglishIMEdict_en2-0L.txt   " reopen file as CP932
:set fileencoding=utf8                     " switch buffer to UTF-8
:set ff=unix                              " convert to LF only
:w ~/.config/nvim/dicts/EnglishIME-utf8.txt
```

---

### 4. Point your blink-cmp config at the new file

```lua
require("blink.cmp").setup({
  sources = {
    default   = { "dictionary", "lsp", "path", "luasnip", "buffer" },
    providers = {
      dictionary = {
        module = "blink-cmp-dictionary",
        name   = "E2J",
        min_keyword_length = 1,
        opts = {
          dictionary_files = {
            vim.fn.expand("~/.config/nvim/dicts/EnglishIMEdict_en2-0L.utf8.txt"),
          },
        },
      },
    },
  },
})
```

After restarting Neovim, you should get clean English→Japanese lookups without any mojibake.

---

The crash you’re seeing happens because the official `edict2` file is encoded
in **EUC-JP**, not UTF-8. You have two simple ways to fix it:

---

## 1) Convert the file to UTF-8 before running the script

```bash
# convert in-place (or write to a new file)
iconv -f EUC-JP -t UTF-8 ~/Downloads/edict2 \
  > ~/.config/nvim/dicts/edict2.utf8

# then run your transformer against the UTF-8 version
python dict_transformerv2.py \
  ~/.config/nvim/dicts/edict2.utf8 \
  ~/.config/nvim/dicts/jmdict_e2j.txt
```

This way your script can keep using `encoding="utf-8"`.

---

## 2) Tell Python to read the original EUC-JP file directly

Edit the top of your `dict_transformerv2.py` so that the input file is opened in `euc_jp`:

```diff
- with open(infile, 'r', encoding='utf-8') as fi, \
-      open(outfile, 'w', encoding='utf-8') as fo:
+ with open(infile, 'r', encoding='euc_jp') as fi, \
+      open(outfile, 'w', encoding='utf-8') as fo:
```

That change alone will let you do:

```bash
python dict_transformerv2.py ~/Downloads/edict2 ~/.config/nvim/dicts/jmdict_e2j.txt
```

—and produce a UTF-8 output file you can plug straight into your `dictionary_files`.

---

### Quick recap

1. **Convert with `iconv`** (preferred if you want a one-off UTF-8 file).
2. **Or** change your Python open call to `encoding="euc_jp"` so it reads the original file.

Either approach gets you past the UnicodeDecodeError and onto having your English→Japanese `.txt` dictionary!

## References

- [Ref01 ](https://www.edrdg.org/jmdict/edict.html)
- [Ref02 ](https://www.edrdg.org/jmdict/edict.html)
- [Ref03 ](https://www.edrdg.org/cgi-bin/wwwjdic/wwwjdic?1C)
- [Ref04 ](https://www.edrdg.org/wwwjdic/wwwjdicinf.html#dicfil_tag)
- [Ref05 ](https://www.edrdg.org/wiki/index.php/JMdict-EDICT_Dictionary_Project)
- [Ref06](https://github.com/schneems/united-dictionary#)

- google dictionary which I managed to convert it to utf-8 instead of its
  original format and then parse it from xaml to the text file using python
  script.
- [englishime](https://nihongo.online/index.php/tools/1-englishime)
