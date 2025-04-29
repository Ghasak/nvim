local M = {}

function M.setup()
  local status_ok, configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then return end

  configs.setup {
    -- make sure you have treesitter for the languages you care about
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- jump forward to textobj
        keymaps = {
          ["if"] = "@function.inner", -- inner function body (no signature)
          ["af"] = "@function.outer", -- outer function (with signature & braces)
        },
      },
    },
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "lua",
      "python",
      "cpp",
      "markdown",
      "markdown_inline",
      "c",
      "lua",
      "sql",
      "html",
      "rust",
      "javascript",
      "query",
      "vim",
      "vimdoc",
      "json",
      "json5",
      "jsdoc",
      "cmake",
      "make",
      "bash",
      -- "help",
    },
    sync_install = false, -- install languages synchronously (only applied to
    ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
    autopairs = { enable = true },
    highlight = {
      enable = true, -- false will disable the whole extension
      use_languagetree = true,
      -- disable = { "c","rust", "phpdoc", "tree-sitter-phpdoc" }, -- list of language that will be disabled
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end
      end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml", "python" } },
  }
end

return M
