return {
  ["rust-analyzer"] = {

    checkOnSave = true,
    -- checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } }, -- depreated in new rust-analyzer
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" },
    },
    imports = { granularity = { group = "module" }, prefix = "self" },
    cargo = { buildScripts = { enable = true } },
    procMacro = { enable = true },
    lens = { enable = true },
  },
}
