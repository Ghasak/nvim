# Avante in Action

Here’s how to get **Avante.nvim** up and running in your Neovim 0.11 on macOS
M1, using **lazy.nvim**, and hook it into your local **Ollama** installation.

---

## 1. Prerequisites

- Neovim ≥ 0.10.1 (you’re on 0.11, so you’re good) ([GitHub][1])
- lazy.nvim already set up
- Ollama CLI installed and at least one model pulled (e.g. `ollama pull llama2`)

It’s also recommended to set

```lua
vim.opt.laststatus = 3
```

so that Avante’s collapsible sidebar behaves properly ([GitHub][1]).

---

## 2. Install via lazy.nvim

Add this to your `lua/plugins.lua` (or wherever you configure lazy):

```lua
require('lazy').setup({
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,         -- always track main
    build   = 'make',        -- compile native bits
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional pickers & icons
      'echasnovski/mini.pick',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
      'zbirenbaum/copilot.lua',
      { 'HakonHarnes/img-clip.nvim', event = 'VeryLazy', opts = { default = { embed_image_as_base64 = false } } },
      { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown','Avante' }, opts = { file_types = { 'markdown','Avante' } } },
    },
    opts = {
      provider = "ollama",
      ollama   = { model = "llama2" },
      mode     = "agentic",       -- use the tool-based planner
      -- you can tweak timeouts, debounce, sidebar position, etc. here
    },
    config = function(_, opts)
      require('avante').setup(opts)
    end,
  },
})
```

([GitHub][1])

---

## 3. Configure Ollama provider

Avante treats Ollama as a first-class provider. With the snippet above:

- It will invoke your local `ollama run <model> --prompt …` under the hood.
- No extra env-vars are needed (unlike cloud APIs).
- Make sure the model you name (e.g. `"llama2"`, `"llama3"`, or `"qwq:32b"`) is installed:

  ```bash
  ollama pull llama2
  ```

([GitHub][1])

---

## 4. Basic usage

1. **Open any code file** in Neovim.
2. **Open the sidebar** with

   ```vim
   <leader>a a
   ```

3. **Ask a question** about your code with

   ```vim
   :AvanteAsk Refactor this function for clarity
   ```

4. **Review suggestions** in the sidebar, then:

   - Press `a` to apply the diff under the cursor
   - Or `A` to apply _all_ changes at once

5. **Switch providers** on the fly with

   ```vim
   :AvanteSwitchProvider
   ```

6. **Start a chat** session across files:

   ```vim
   :AvanteChat
   ```

7. **Explore other commands**:

   - `:AvanteModels` — list your Ollama models
   - `:AvanteToggle` — show/hide sidebar
   - `:AvanteRefresh` — refresh current view
   - `:AvanteSwitchSelectorProvider` — pick between fuzzy, telescope, mini.pick, etc.
     ([GitHub][1])

---

## 5. Key bindings cheat-sheet

| Binding      | Action                    |
| ------------ | ------------------------- |
| `<leader>aa` | Open Avante sidebar       |
| `<leader>at` | Toggle sidebar visibility |
| `<leader>ar` | Refresh sidebar           |
| `<leader>af` | Focus sidebar             |
| `<leader>a?` | Select model              |
| `<leader>ae` | Edit selected blocks      |
| `<leader>aS` | Stop request              |
| `<leader>ah` | Cycle chat history        |

Conflict resolution (“ours/theirs”) and jump mappings are auto-set for you unless you override ([GitHub][1]).

---

## 6. Managing features

- Tweak **behavior** (e.g. `auto_suggestions`, `minimize_diff`) under `behaviour` in `opts`.
- Customize **windows** (sidebar width, position) under `windows`.
- Enable **cursor-planning mode** for better multi-step code gen:

  ```lua
  opts.mode = "agentic"
  ```

- Add your own **custom tools** (e.g. run tests) via the `custom_tools` table.
- Use **RAG Service** with Ollama by setting:

  ```lua
  rag_service = {
    enabled = true,
    provider = "ollama",
    host_mount = os.getenv("HOME"),
  }
  ```

  and ensure Docker/OrbStack is running ([GitHub][1]).

---

## 7. Next steps

- Experiment with different Ollama models (`:AvanteModels`).
- Try **AiHubMix** or **OpenAI** side-by-side by switching `provider` and env-vars.
- Dive into the wiki for **custom providers** or **advanced selector** setups.

With this in place, your Neovim should now feel _just_ like a Cursor-style AI
IDE—powered entirely by your local Ollama models. Enjoy!

[1]: https://github.com/yetone/avante.nvim "GitHub - yetone/avante.nvim: Use your Neovim like using Cursor AI IDE!"



