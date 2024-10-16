# NVIM WITH FZF NAVIGATION

You can use `fzf` outside of `nvim` in your terminal to select a file and then open it in `nvim`. Here’s how you can achieve that:


### 1. Using `fzf` with `nvim` in Terminal

You can use a simple shell command that pipes the selected file from `fzf` into `nvim` like this:

```bash
nvim $(fzf)
```

This will:

- Run `fzf` in your terminal.
- After you select a file in `fzf` (pressing `<Enter>`), it will open the file in `nvim`.

### 2. Opening Multiple Files

If you want to open multiple files in `nvim`, you can use the `-m` option in `fzf` to allow multi-selection:

```bash
nvim $(fzf -m)
```

With `-m`, you can select multiple files by pressing `Tab` and then press `<Enter>`. All selected files will be opened in `nvim`.

### 3. Opening Files in a New Tab, Split, or Vertical Split

You can extend this by using shell functions or scripts to customize how the files open in `nvim`.

#### Open in a New Tab

You can open a file in a new tab in `nvim` using the following command:

```bash
nvim -p $(fzf)
```

#### Open in a Horizontal Split

For a horizontal split, use this command:

```bash
nvim -o $(fzf)
```

#### Open in a Vertical Split

For a vertical split, use this:

```bash
nvim -O $(fzf)
```

### 4. Creating a Shell Function (Optional)

If you want to make this a bit more convenient, you can create a shell function in your `.bashrc` or `.zshrc`:

```bash
# Function to open file with fzf and nvim
fznvim() {
    nvim $(fzf)
}
```

Then, after restarting your terminal or sourcing your shell config (`source ~/.bashrc` or `source ~/.zshrc`), you can use the `fznvim` command to quickly select and open a file from `fzf` in `nvim`.

This gives you the power of `fzf` directly in your terminal for quick file selection and editing with `nvim`.

