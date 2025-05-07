--  -############################################################################
--  -#                                                                          #
--  -#                         ░▀▀█░█▀█░█░█░█▀█░░░░                             #
--  -#                         ░░░█░█▀█░▀▄▀░█▀█░░░░                             #
--  -#                         ░▀▀░░▀░▀░░▀░░▀░▀░░░░                             #
--  -#        ░█░░░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░░░█▀▀░█▀▀░█▀▄░█░█░█▀▀░█▀▄░░░░    #
--  -#        ░█░░░█▀█░█░█░█░█░█░█░█▀█░█░█░█▀▀░░░▀▀█░█▀▀░█▀▄░▀▄▀░█▀▀░█▀▄░░░░    #
--  -#        ░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░░░░    #
--  -#             ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░░░░░░█▀▀░▀█▀░█░░░█▀▀                #
--  -#             ░█░░░█░█░█░█░█▀▀░░█░░█░█░░░░░░█▀▀░░█░░█░░░█▀▀                #
--  -#             ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀░░░░▀░░░▀▀▀░▀▀▀░▀▀▀                #
--  -#                                                                          #
--  -############################################################################
-- Created with: https://budavariam.github.io/asciiart-text/
-- Using Pagga font
-- :MasonInstall java-test
-- :MasonInstall java-debug-adapter
-- :MasonInstall jdtls
-- ○ lua-async-await
-- ○ nvim-java
-- ○ nvim-java-core
-- ○ nvim-java-dap
-- ○ nvim-java-refactor
-- ○ nvim-java-test
-- ○ spring-boot.nvim

-- +----------------------------------------------------------------------+
-- +  ┌────────────┐           ┌────────────────┐                         +
-- +  │ nvim-jdtls │           │ nvim-lspconfig │                         +
-- +  └────────────┘           └────────────────┘                         +
-- +       |                         |                                    +
-- +      start_or_attach           nvim_lsp.jdtls.setup                  +
-- +       │                              |                               +
-- +       │                             setup java filetype hook         +
-- +       │    ┌─────────┐                  │                            +
-- +       └───►│ vim.lsp │◄─────────────────┘                            +
-- +            └─────────┘                                               +
-- +                .start_client                                         +
-- +                .buf_attach_client                                    +
-- +                                                                      +
-- +----------------------------------------------------------------------+
local jdtls = require "jdtls"
local home = vim.env.HOME -- Get the home directory

-- Path to Java 17+ (Adjust if necessary)
-- local java_home = home .. "/.sdkman/candidates/java/17.0.10-tem"
-- local java_home = home .. "/.sdkman/candidates/java/17.0.10-zulu"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local java_home = home .. "/.sdkman/candidates/java/21.0.2-zulu"

local workspace_dir = home .. "/.cache/jdtls-workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🌟 Java Debug & Test Adapters Configuration (DAP Bundles)                    │
-- │                                                                              │
-- │ 📅 As of Thu Apr. 24, Mason is unable to install:                            │
-- │   ❌ java-debug-adapter                                                      │
-- │   ❌ java-test                                                               │
-- │                                                                              │
-- │ 🛠️ Manual Setup (via VSIX Downloads):                                        │
-- │   1️⃣ Java Debug Adapter:  https://www.vsixhub.com/vsix/1954/                  │
-- │   2️⃣ Java Test Adapter:   https://www.vsixhub.com/vsix/2032/                  │
-- │                                                                              │
-- │ 📂 Placement Instructions:                                                   │
-- │   - Extract `vscode-java-debug` to:   ~/.local/share/nvim/java-debug/        │
-- │   - Extract `vscode-java-test` to:    ~/.local/share/nvim/java-test/         │
-- │                                                                              │
-- │ 🧩 Purpose:                                                                  │
-- │ This logic loads the Java Debug and Test adapters into Neovim's jdtls setup. │
-- │   - ✅ Prioritizes Mason-installed adapters                                  │
-- │   - 🔄 Falls back to manual setup if Mason adapters are unavailable          │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

-- ================= Mason 2-compatible path discovery =================
-- Mason keeps everything under:  <stdpath("data")>/mason
local mason_root = vim.fn.stdpath "data" .. "/mason"
local jdtls_install_path = mason_root .. "/packages/jdtls"
local jdtls_launcher = vim.fn.globpath(
  jdtls_install_path .. "/plugins",
  "org.eclipse.equinox.launcher_*.jar",
  false, -- non-recursive
  true -- return list
)[1]

if not jdtls_launcher or jdtls_launcher == "" then
  vim.notify("JDTLS launcher not found under " .. jdtls_install_path, vim.log.levels.ERROR)
  return
end

-- ================= WORKAROUND: Find Launcher using vim.fn.glob ==================
local jdtls_launcher
local launcher_glob_pattern = jdtls_install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
-- print("DEBUG(fn.glob): Launcher pattern: " .. vim.inspect(launcher_glob_pattern))

-- Use vim.fn.glob and vim.split
local launcher_glob_ok, launcher_glob_result_str = pcall(vim.fn.glob, launcher_glob_pattern)

if not launcher_glob_ok or launcher_glob_result_str == nil or launcher_glob_result_str == "" then
  vim.notify(
    "ERROR(fn.glob): Could not find jdtls launcher JAR using pattern: " .. launcher_glob_pattern .. " (Check Mason jdtls installation?)",
    vim.log.levels.ERROR
  )
  return -- Stop config execution if launcher not found
end

-- Split the result string into a table (list)
local launcher_glob_list = vim.split(launcher_glob_result_str, "\n")
-- print("DEBUG(fn.glob): Split launcher results: " .. vim.inspect(launcher_glob_list))

if #launcher_glob_list == 0 then
  vim.notify("ERROR(fn.glob): Split glob result was empty for launcher pattern: " .. launcher_glob_pattern, vim.log.levels.ERROR)
  return
end

jdtls_launcher = launcher_glob_list[1] -- Get the first match
-- ================= END WORKAROUND =============================================
--

local dap_install_path = mason_root .. "/packages/java-debug-adapter/extension/server"
local test_install_path = mason_root .. "/packages/java-test/extension/server"

-- Gather *.jar bundles from the two adapter directories
local bundles = {}

local function add_jars(dir, pattern) -- ✅ list already returned
  for _, jar in ipairs(vim.fn.globpath(dir, pattern, false, true)) do
    if jar ~= "" then table.insert(bundles, jar) end
  end
end

add_jars(dap_install_path, "com.microsoft.java.debug.plugin-*.jar")
add_jars(test_install_path, "*.jar") -- picks up runner + server jars

-- The actual jdtls configuration
local config = {
  cmd = {
    java_home .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- Add Lombok agent
    "-javaagent:"
      .. home
      .. "/.m2/repository/org/projectlombok/lombok/1.18.34/lombok-1.18.34.jar",
    "-classpath",
    home .. "/.m2/repository/org/projectlombok/lombok/1.18.34/lombok-1.18.34.jar",
    "-jar",
    jdtls_launcher,
    "-configuration",
    jdtls_install_path .. "/config_" .. (vim.fn.has "mac" == 1 and "mac" or "linux"),
    "-data",
    workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle" },

  settings = {
    java = {
      home = java_home,
      import = {
        gradle = {
          wrapper = {
            enabled = true,
          },
        },
      },
      eclipse = { downloadSources = true },
      configuration = {
        -- updateBuildConfiguration = "interactive",
        updateBuildConfiguration = "automatic",
        runtimes = {
          { name = "JavaSE-21", path = home .. "/.sdkman/candidates/java/21.0.2-zulu", default = true },
          { name = "JavaSE-18", path = home .. "/.sdkman/candidates/java/18.0.1-zulu" },
          { name = "JavaSE-17", path = home .. "/.sdkman/candidates/java/17.0.10-tem" },
          { name = "JavaSE-17", path = home .. "/.sdkman/candidates/java/17.0.10-zulu" },
          { name = "JavaSE-1.8", path = home .. "/.sdkman/candidates/java/8.0.332-zulu" },
        },
      },
      maven = { downloadSources = true, userSettings = home .. "/.m2/settings.xml" },
      annotationProcessing = {
        enabled = true,
        profile = "default",
        profiles = {
          default = {
            sourceLevel = "21",
            annotationProcessorPaths = {
              {
                groupId = "org.projectlombok",
                artifactId = "lombok",
                version = "1.18.34",
              },
            },
          },
        },
      },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
    },
    signatureHelp = { enabled = true },
    format = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = { "java", "javax", "com", "org" },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  init_options = {
    bundles = bundles, -- Pass the collected bundles for debug adapter, etc.
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

---------------------------------------------------------------------
-- Load your diagnostics and custom on_attach
local diagnostics = require "plugins.configs.lsp.lsp_settings"
diagnostics.setup()

local base_on_attach = require("plugins.configs.lsp.lsp_attach").custom_attach

local opts = {
  on_attach = function(client, bufnr)
    diagnostics.on_attach(client, bufnr) -- Your diagnostics setup
    base_on_attach(client, bufnr) -- Your existing lsp_attach logic

    -- Add JDTLS-specific setup (DAP, etc.)
    jdtls.setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
  capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities,
  special_attach = require("plugins.configs.lsp.lsp_special_attach").custom_attach,
}

-- Assign opts.on_attach and capabilities to your jdtls config
config.on_attach = opts.on_attach
config.capabilities = opts.capabilities

---------------------------------------------------------------------

--Add keymaps specific to Java/jdtls after attach (optional, but useful)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspJavaSettings", { clear = true }),
  pattern = "*.java",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { buffer = args.buf, desc = "JDTLS Organize Imports" })
      vim.keymap.set("n", "<leader>cv", jdtls.extract_variable, { buffer = args.buf, desc = "JDTLS Extract Variable" })
      vim.keymap.set(
        "v",
        "<leader>cv",
        function() jdtls.extract_variable(true) end,
        { buffer = args.buf, desc = "JDTLS Extract Variable (Visual)" }
      )
      vim.keymap.set("n", "<leader>cc", jdtls.extract_constant, { buffer = args.buf, desc = "JDTLS Extract Constant" })
      vim.keymap.set(
        "v",
        "<leader>cc",
        function() jdtls.extract_constant(true) end,
        { buffer = args.buf, desc = "JDTLS Extract Constant (Visual)" }
      )
      vim.keymap.set(
        "v",
        "<leader>cm",
        function() jdtls.extract_method(true) end,
        { buffer = args.buf, desc = "JDTLS Extract Method (Visual)" }
      )
      vim.keymap.set("n", "<leader>djc", function() jdtls.compile() end, { buffer = args.buf, desc = "JDTLS Compile" })
      vim.keymap.set("n", "<leader>djt", function() jdtls.test_class() end, { buffer = args.buf, desc = "JDTLS Debug Test Class" })
      vim.keymap.set(
        "n",
        "<leader>djm",
        function() jdtls.test_nearest_method() end,
        { buffer = args.buf, desc = "JDTLS Debug Test Method" }
      )
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end,
})

-- 2. (Optional) Fire a “didChangeWatchedFiles” on save
-- If you still see a delay, add this after your jdtls.start_or_attach(config) call:
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.java",
  callback = function()
    local uri = vim.uri_from_fname(vim.fn.expand "%:p")
    vim.lsp.buf_notify(0, "workspace/didChangeWatchedFiles", {
      changes = { { uri = uri, type = 2 } }, -- 2 = Created/Changed
    })
  end,
})

-- Start the jdtls language server
jdtls.start_or_attach(config)
