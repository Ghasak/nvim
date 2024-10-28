# Enhanced Vimscript

The issue you're encountering suggests that the extracted word contains
**unexpected characters or spaces**. The `E486: Pattern not found` error means
that Neovim can't find the escaped word in the buffer. This often happens if
the word extraction is incorrect or if quotes are not handled properly.

Let’s walk through **enhanced versions** of both the Vimscript and Lua
implementations to properly handle this.

---

### **Corrected Vimscript Version**

```vim
function! s:better_sub() abort
  let reg = getreg(0)          " Get content from register 0
  let line = getline('.')       " Get the current line
  let start = col("'<")         " Start of visual selection
  let end = col("'>")           " End of visual selection

  " Handle reversed selection
  if start > end
    let temp = start
    let start = end
    let end = temp
  endif

  " Extract the selected word (trim quotes or spaces)
  let word = substitute(line[start - 1 : end - 1], '"', '', 'g')

  " Escape any special characters in the word
  let escaped_word = escape(word, '\.*[]~$^')

  " Perform the global substitution
  try
    exec "%s/\\<" . escaped_word . "\\>/" . reg . "/g"
  catch /^Vim\%((\a\+)\)\=:E486/
    echom "Error: Pattern not found for word: '" . escaped_word . "'"
  endtry

  " Exit visual mode
  call feedkeys("\<Esc>")
endfunction

" Map to <leader>z
noremap <leader>z <cmd>call <SID>better_sub()<CR>
```

---

### **Improvements:**

1. **`substitute()`**: Strips out problematic characters like quotes (`"`).
2. **`escape()`**: Escapes special characters to avoid pattern errors.
3. **`try-catch`**: Handles the `E486` error gracefully with a message if the word isn't found.

---

### **Lua Version:**

```lua
local function better_sub()
  local reg_content = vim.fn.getreg("0")  -- Get content from register 0
  local line = vim.fn.getline(".")        -- Get the current line
  local start_col = vim.fn.col("'<")      -- Start of visual selection
  local end_col = vim.fn.col("'>")        -- End of visual selection

  -- Handle reversed selection
  if start_col > end_col then
    start_col, end_col = end_col, start_col
  end

  -- Extract the selected word (trim quotes and spaces)
  local word = line:sub(start_col, end_col - 1):gsub('"', '')

  -- Escape special characters
  local escaped_word = vim.fn.escape(word, [[\.*[]~$^]])

  -- Perform the global substitution
  local success, err = pcall(function()
    vim.cmd(string.format("%%s/\\<%s\\>/%s/g", escaped_word, reg_content))
  end)

  if not success then
    print(string.format("Error: Pattern not found for word: '%s'", escaped_word))
  end

  -- Exit visual mode
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "n", true
  )
end

-- Map the function to <leader>z
vim.keymap.set("n", "<leader>z", better_sub, { desc = "Replace visual selection with register 0" })
```

---

### **Why This Works:**

1. **`gsub()` in Lua**: Removes unwanted quotes or special characters from the extracted word.
2. **`escape()`**: Escapes special characters like dots, brackets, etc., to prevent errors.
3. **`pcall()`**: Catches any errors and prints a meaningful message instead of crashing.

These versions ensure that the selected word is correctly processed and avoid
issues related to regex patterns or incorrect selections.

