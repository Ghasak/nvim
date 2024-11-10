local M = {}

M.config = function()
  local status_ok, myconform = pcall(require, "conform")
  if not status_ok then
    return
  end

  myconform.setup {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphal = { "prettier" },
      lua = { "stylua" },
      --cpp = { "clang-format" },
      cpp = { "my_cpp_formatter" },
      python = { "yapf", "isort", "black" },
      r = { "my_r_formatter" },
      rmd = { "my_r_formatter" },
      rust = { "my_rust_formatter" },
      sql = { "my_sql_formatter" },
    },
    -- ***************************
    -- Format on save feature
    -- ***************************
    -- format_on_save = {
    --     lsp_fallback = true, -- means fallback to lsp.format if not available
    --     async = false, -- make it sync,
    --     timeout_ms = 500 -- if cannot format by this time it will exit
    -- },
    -- Define custom formatters here
    formatters = {
      -- ***************************
      --    Formatter for Rust
      -- ***************************
      my_rust_formatter = { command = "rustfmt", args = { "--edition=2021" } },
      my_cpp_formatter = {
        command = "/opt/homebrew/bin/clang-format",
        --args = "--style=file:~/Desktop/devCode/cppDev/AnimationEngineCPP/.clang-format",
        args = "--style=file",
        stdin = true,
      },
      my_sql_formatter = {
        command = "/opt/homebrew/bin/sql-formatter",
        stdin = true, -- Ensure the input streamed directly to the formatter inside the R session, as you see in `stdin` above.
      },
      -- ***************************
      --    Formatter for R-Language
      -- ***************************
      -- Ensure you already installed the readr package using install.packages("readr") inside R session.
      -- If you want to run the formatter directly to a given file use (R --slave --no-restore --no-save -f main.r)
      my_r_formatter = {
        command = "Rscript",
        args = {
          "--slave",
          "--no-restore",
          "--no-save",
          "-e",
          "styler::style_text(readr::read_file(file('stdin')))",
        },
        stdin = true, -- Ensure the input streamed directly to the formatter inside the R session, as you see in `stdin` above.
      },
    },
  }
  -- Create the command line for formatting based on conform, we call it Format
  vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, end_line:len() },
      }
    end
    myconform.format {
      async = true,
      lsp_fallback = true,
      range = range,
    }
  end, { range = true })
end

return M
