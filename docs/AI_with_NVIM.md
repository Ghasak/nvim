# AI with Nvim

If you use `ollama` with your current workingflow and want to verify if it works or not use:

1. Verify the OpenAI-compatible endpoint

In a separate shell, run:

```sh
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma3:27b",
    "messages": [{ "role": "user", "content": "Hello!" }]
  }'
.
```

- If you get back valid JSON with .choices[0].message.content, you know /v1/chat/completions is live and your adapter should work as-is.
- If you still see 404, your Ollama server is only serving the legacy endpoint.
- Ollama’s HTTP API is OpenAI-compatible on /v1/chat/completions once you’ve run ollama serve (no extra flags)

## OOLAMA

- [Ollama Model](https://github.com/jmorganca/ollama)

## Nvim AI Plugins

Here are several Neovim plugins that give you a GitHub Copilot–style tab-completion experience by driving suggestions from your local Ollama models:

---

#### 1. **Jacob411/Ollama-Copilot**

A full “Copilot-like” tab-completion plugin that runs an LSP server under the hood and streams ghost-text suggestions as you type.

- **Features**
  - Copilot-style `<Tab>` accept, with real-time streaming
  - Debounced requests (to avoid CPU spikes)
  - Configurable trigger events & filetypes
- **Install** (using [lazy.nvim](https://github.com/folke/lazy.nvim)):
  ```lua
  {
    "Jacob411/Ollama-Copilot",
    opts = {
      model_name      = "deepseek-coder:base",
      stream_suggestion = true,
      python_command  = "python3",
      filetypes       = { "lua","python","js","ts" },
      ollama_model_opts = { num_predict = 40, temperature = 0.1 },
      keymaps = {
        suggestion   = "<leader>os",
        insert_accept = "<Tab>",
        reject       = "<leader>or",
      },
    },
  }
  ```
   ([GitHub - Jacob411/Ollama-Copilot: Neovim plugin for code completion](https://github.com/Jacob411/Ollama-Copilot))

---

#### 2. **Faywyn/llama-copilot.nvim**

A minimal plugin exposing two commands—`:LlamaCopilotComplet` and `:LlamaCopilotAccept`—for on-demand code generation via your Ollama models.

- **Features**
  - Zero config if you’re happy with default host/port (`localhost:11434`) and `codellama:7b-code`
  - Simple Lua API for swapping in any Ollama server or model
- **Install** (with [packer.nvim](https://github.com/wbthomason/packer.nvim)):
  ```lua
  use {
    "Faywyn/llama-copilot.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("llama-copilot").setup({
        host = "localhost",
        port = "11434",
        model = "codellama:7b-code",
        max_completion_size = 15,
      })
    end,
  }
  ```
   ([GitHub - Faywyn/llama-copilot.nvim: Use ollama llms for code completion](https://github.com/Faywyn/llama-copilot.nvim))

---

#### 3. **meeehdi-dev/bropilot.nvim**

“Bropilot” is a drop-in Copilot alternative that pulls completions from Ollama’s API with sensible defaults for auto-suggest.

- **Features**
  - Automatic debounced suggestions (`auto_suggest = true`)
  - Support for any Ollama-pulled model (`qwen2.5-coder`, `starcoder2`, `codellama`, etc.)
  - Fine-tunable model-params & per-word/line/block keymaps
- **Install** (lazy-load on `VeryLazy`):
  ```lua
  {
    "meeehdi-dev/bropilot.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      provider      = "ollama",
      auto_suggest  = true,
      model         = "starcoder2:3b",
      debounce      = 500,
      keymap = {
        accept_line = "<M-Right>",
        accept_word = "<C-Right>",
      },
      ollama_url    = "http://localhost:11434/api",
    },
    config = true,
  }
  ```
   ([GitHub - meeehdi-dev/bropilot.nvim: Neovim code suggestion and completion (just like GitHub Copilot, but locally using Ollama)](https://github.com/meeehdi-dev/bropilot.nvim))

---

#### 4. **marco-souza/ollero.nvim**

“Ollero” gives you lightweight text-completion & prompt-management by talking directly to your local Ollama instance.

- **Features**
  - Offline model management (list/pull via Ollama API)
  - Simple Lua bindings for sending prompts & inserting completions
- **Install** (with lazy.nvim or packer):
  ```lua
  use {
    "marco-souza/ollero.nvim",
    config = function()
      require("ollero").setup({
        host = "localhost",
        port = 11434,
      })
    end,
  }
  ```
   ([
  marco-souza/ollero.nvim - Neovim plugin | Developers using ollero.nvim | Alternatives
  to ollero.nvim
  ](https://dotfyle.com/plugins/marco-souza/ollero.nvim))

---

#### 5. **olimorris/codecompanion.nvim**

While primarily a “Copilot Chat”–style inline assistant, Code Companion also supports Ollama as one of its multiple back-end adapters—so you get both chat and ghost-text completions in Neovim.

- **Features**
  - Copilot-Chat buffers + inline completion
  - Support for Anthropic, Gemini, **Ollama**, OpenAI, etc.
  - Custom actions, async execution & buffer-context awareness
- **Install**:
  ```lua
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codecompanion").setup({
        adapters = { ollama = { url = "http://localhost:11434" } },
      })
    end,
  }
  ```
   ([GitHub - olimorris/codecompanion.nvim: ✨ A Copilot Chat experience in… | Christopher Valerio](https://www.linkedin.com/posts/christopher-valerio_github-olimorriscodecompanionnvim-activity-7287622581568864256-Pbf4))

---

**Which to pick?**

- For _pure Copilot-style tab completions_, **Ollama-Copilot**, **llama-copilot.nvim** or **Bropilot.nvim** are the most “drop-in.”
- If you also want a chat-buffer + inline-edit workflow, **codecompanion.nvim** has built-in support for Ollama.
- Want something ultra-light? **ollero.nvim** is the simplest way to hook into your Ollama server for ad-hoc completion.

All of the above work over your **local** Ollama API—no cloud calls, full privacy, and zero Copilot subscription required.

## Trying

```lua

  -- Custom configuration (defaults shown)
  {
    "meeehdi-dev/bropilot.nvim",
    event = "VeryLazy", -- preload model on start
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",
    },
    opts = {
      auto_suggest = true,
      model = "qwen2.5-coder:32b",
      debounce = 500,
      keymap = {
        accept_line = "<leader><Tab>",
      },
    },
    config = function(_, opts) require("bropilot").setup(opts) end,
  },
  {
    "nomnivore/ollama.nvim",
    cond = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
      -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama prompt",
        mode = { "n", "v" },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oG",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "ollama Generate Code",
        mode = { "n", "v" },
      },
    },

    ---@type Ollama.Config
    opts = {
      -- your configuration overrides
    },
  },

  {
    "stevearc/oil.nvim",
    cond = false,
    event = "VimEnter",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function() require("plugins.configs.p27_myOilConfig").config() end,
  },

```
