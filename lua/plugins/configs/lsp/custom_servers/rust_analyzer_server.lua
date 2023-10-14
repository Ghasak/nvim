return {
  ["rust-analyzer"] = {

    imports = { granularity = { group = "module" }, prefix = "self" },
    cargo = { buildScripts = { enable = true } },
    procMacro = { enable = true },
    lens = { enable = true },
    checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } },
  },
}
