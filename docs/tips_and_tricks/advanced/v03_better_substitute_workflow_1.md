# Better Substitute Workflow 1

All these commands can work to the entir buffer using `%` or for specific part
for example `vip`: Vitualize Inside Paragraph.

1. Replace with empty register

FORMULA:

- At all the instances that you want to change pick one and click `*`, for example on top of `Jackson_Nilson`
- Now, it is scored in register 0
- Apply `:%s//the_other_word`

```
Mikahil_Gorbachov


Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson

```

- You will get

```
Mikahil_Gorbachov


Mikahil_Gorbachov
Mikahil_Gorbachov
Mikahil_Gorbachov
Mikahil_Gorbachov
Mikahil_Gorbachov
```

2. Past the content of any register with `Ctrl + r`

- Yank the first word
- Yank the second word
- [optional] Check the register, using `:Reg` or using `""` or `"` in normal mode.
- Now, you can use `:%s/ here you click Ctrl + r then put 0 for register 0 and
/ Ctrl + r again with 1 for register 1` notice that register 0 has the first
  yanked word and 1 has the second yanked word.
  - Later I noticed that register `0` for most recent yanked or deleted while
    `-` is for the other word that you yanked.
  - Check the note at the end, you can always check the register using
    `:regsiters`

```
Mikahil_Gorbachov


Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson

```

will become

```
Mikahil_Gorbachov


Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson

```

3. Past with `Ctrl+r` followed by `Ctrl+w`

- Yank the first word
- Put the cursor on top of any of the word that you want to replace
- Use `0` to the yanked first word, while `Ctrl+r` then `Ctrl +w` will give you the second word

```
Mikahil_Gorbachov


Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson
Jackson_Nilson

```

- You can also apply this to the whole buffer using this shortcut.

```vim
nnoremap <leader>Z :%s/<C-R><C-W>/<C-R>0/g<CR>
```

---

## SIDE NOTE

In Neovim (and Vim), when you yank text, the default behavior involves the
**unnamed register (`"`)** and **register `0`**. However, only the most recent
yank is stored in **register `0`**, meaning that subsequent yanks overwrite it.
It seems like you want an option to maintain **multiple yanks across
registers**, similar to a stack or rotating buffer (register `0`, `1`, `2`, and
so on). Let me walk you through the behavior and potential solutions.

---

### **1. Default Register Behavior in Vim/Neovim**

- **`"0` register**: Stores the most recent yank.
- **`"1` register**: Stores the most recent **delete** (cut) operation (but not yanks).
- **Subsequent yanks** will overwrite **register `0`**, and only deletes populate the `"1`-`"9` registers in a rotation.

There’s **no built-in native way** to automatically rotate yanks into `"1`,
`"2`, etc. like a yank history, but here are several workarounds.

---

### **2. Workaround: Use the Unnamed Register (`"`) with Appending to Registers**

If you want **multiple yanks to accumulate** in a register, you can **append**
to a specific register manually.

- **Yank and append to the same register:**
  ```vim
  "ayiw      " Yank the first word into register `a`.
  "Ayiw      " Append the second word to the same register `a`.
  ```

This way, you can accumulate yanks in a register without overwriting.

---

### **3. Option: Use a Mapping to Rotate Registers (Custom Solution)**

You can write a **Neovim Lua** function or Vimscript that **automatically
rotates yanks** into numbered registers (`"0`, `"1`, `"2`, etc.).

Here’s an example using Vimscript to automate this:

#### Vimscript Yank Rotation Function:

```vim
let s:register_index = 0

function! RotateYank()
  let reg = string(s:register_index)
  execute 'normal! "' . reg . 'y'
  let s:register_index = (s:register_index + 1) % 10  " Rotate between 0-9
endfunction

nnoremap <leader>y :call RotateYank()<CR>
```

- This script rotates yanks between registers `"0` to `"9`.
- Press `<leader>y` to yank and store the result in a rotating register.

---

### **4. Plugin Alternative: `vim-yankstack`**

If you prefer not to write custom scripts, you can use the **`vim-yankstack`**
plugin. This plugin gives you a yank history similar to the **kill ring** in
Emacs, allowing you to cycle through previous yanks.

#### Install with `vim-plug`:

```vim
Plug 'svermeulen/vim-yankstack'
```

#### Usage:

- Yank as usual, and the plugin will maintain a history.
- Use `<C-p>` (Ctrl+P) and `<C-n>` (Ctrl+N) to cycle through the yank history.

---

### **5. Restoring Default Behavior with Register `0`**

If you want to reset your yank behavior back to the **default**, ensuring only
the most recent yank goes into register `0`, you don’t need any special
configuration. Just ensure no mappings are interfering with default yank
behavior.

---

### **Summary:**

- **Appending yanks** to the same register: Use `A` (e.g., `"Ayiw`).
- **Automate rotating yanks**: Use the custom Vimscript solution.
- **Yank history management**: Use the `vim-yankstack` plugin.
  **Default behavior**: Register `0` holds the most recent yank only.

This way, you can choose between **manual accumulation**, **automatic rotation**, or a **plugin solution** based on your needs.

- [Check this plugin](https://github.com/gbprod/yanky.nvim)
- [Vim Trick: Better Substitute Workflow 1 ](https://www.youtube.com/watch?v=k_PBlhH-DKk&list=PLOe6AggsTaVsdFEX7_U9k4YDyMMNb--zx&index=3&ab_channel=YukiUthman)

