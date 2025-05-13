return {
  ["rust-analyzer"] = {

    checkOnSave = true,
    files = {
        -- skip walking your build output
        excludeDirs = { "target" },
    },


    -- checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } }, -- depreated in new rust-analyzer
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" },
    },
    imports = { granularity = { group = "module" }, prefix = "self" },
    cargo = { buildScripts = { enable = true },
             loadOutDirsFromCheck = false
    },
    procMacro = { enable = true },
    lens = { enable = true },
  },
}
