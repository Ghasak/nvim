local M = {}

function M.setup()
  local status_ok, configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  configs.setup {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "lua",
      "python",
      "cpp",
      "markdown",
      "c",
      "lua",
      "sql",
      "html",
      "rust",
      "javascript",
      "vim",
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
      disable = { "phpdoc", "tree-sitter-phpdoc" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    --context_commentstring = { enable = true, enable_autocmd = false },
  }
end

return M
