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

-- 🛠️ Debug Adapter: Check Mason first, fallback to manual
local mason_debug_jar = vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar")
local manual_debug_jar = vim.fn.glob(home .. "/.local/share/nvim/java-debug/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)

-- 📦 Aggregate Debug Adapter
local bundles = {}
if mason_debug_jar ~= "" then
  table.insert(bundles, mason_debug_jar) -- ✅ Mason's debug adapter found
else
  if not vim.g.java_debug_adapter_loaded then
    table.insert(bundles, manual_debug_jar) -- 🔄 Fallback to manual debug adapter
    vim.notify("loaded java-debug-adapter manually!", vim.log.levels.INFO, { title = "java-debug-adapter Setup" })

    -- Mark as loaded
    vim.g.java_debug_adapter_loaded = true
  end
end

-- 🧪 Test Adapter: Check Mason first, fallback to manual
local mason_test_jars = vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
local manual_test_jars = vim.split(vim.fn.glob(home .. "/.local/share/nvim/java-test/extension/server/*.jar", 1), "\n")

-- 📦 Aggregate Test Adapter
if #mason_test_jars > 0 and mason_test_jars[1] ~= "" then
  vim.list_extend(bundles, mason_test_jars) -- ✅ Mason test jars found
else
  if not vim.g.java_test_loaded then
    -- your debug + test adapter setup (bundles logic)

    -- Example notification (only once)
    vim.notify("loaded java-test manually!", vim.log.levels.INFO, { title = "Java DAP Setup" })
    vim.list_extend(bundles, manual_test_jars) -- 🔄 Fallback to manual test jars

    -- Mark as loaded
    vim.g.java_test_loaded = true
  end
end

-- ✅ 'bundles' is now ready to be injected into the jdtls configuration

-- Get JDTLS install path robustly
local jdtls_install_path
local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
if not mason_registry_ok then
  vim.notify("ERROR: nvim-jdtls config: Failed to load mason-registry.", vim.log.levels.ERROR)
  return
end
local jdtls_package = mason_registry.get_package "jdtls"
if not jdtls_package then
  vim.notify("ERROR: nvim-jdtls config: jdtls package not found in mason-registry.", vim.log.levels.ERROR)
  return
end
jdtls_install_path = jdtls_package:get_install_path()
if not jdtls_install_path then
  vim.notify("ERROR: nvim-jdtls config: Could not get jdtls install path from Mason.", vim.log.levels.ERROR)
  return
end
-- print("DEBUG: jdtls_install_path: " .. vim.inspect(jdtls_install_path))

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
-- print("DEBUG(fn.glob): Found jdtls_launcher: " .. vim.inspect(jdtls_launcher))
-- ================= END WORKAROUND =============================================

-- Get paths for debug/test tools (robustly)
local dap_pkg = mason_registry.get_package "java-debug-adapter"
local dap_install_path = dap_pkg and dap_pkg:get_install_path()
if dap_install_path then
  dap_install_path = dap_install_path .. "/extension/server/"
else
  dap_install_path = ""
end

local test_pkg = mason_registry.get_package "java-test"
local test_install_path = test_pkg and test_pkg:get_install_path()
if test_install_path then
  test_install_path = test_install_path .. "/extension/server/"
else
  test_install_path = ""
end

-- Find bundles using vim.fn.glob
-- local bundles = {} -- Initialize empty table for bundles

-- Find Debug bundles
if dap_install_path ~= "" then
  local debug_bundle_pattern = dap_install_path .. "com.microsoft.java.debug.plugin-*.jar" -- Adjust if needed
  -- print("DEBUG(fn.glob): Debug bundle pattern: " .. vim.inspect(debug_bundle_pattern))
  local glob_ok, debug_str = pcall(vim.fn.glob, debug_bundle_pattern)
  if glob_ok and debug_str and debug_str ~= "" then
    local debug_list = vim.split(debug_str, "\n")
    if #debug_list > 0 then
      vim.list_extend(bundles, debug_list)
      -- print("DEBUG(fn.glob): Added debug bundles: " .. vim.inspect(debug_list))
    end
  else
    -- print("DEBUG(fn.glob): No debug bundles found: " .. debug_bundle_pattern)
  end
end

-- Find Test bundles
if test_install_path ~= "" then
  local test_bundle_pattern = test_install_path .. "com.microsoft.java.test.runner-*.jar" -- Adjust if needed
  -- print("DEBUG(fn.glob): Test bundle pattern: " .. vim.inspect(test_bundle_pattern))
  local glob_ok, test_str = pcall(vim.fn.glob, test_bundle_pattern)
  if glob_ok and test_str and test_str ~= "" then
    local test_list = vim.split(test_str, "\n")
    if #test_list > 0 then
      vim.list_extend(bundles, test_list)
      -- print("DEBUG(fn.glob): Added test bundles: " .. vim.inspect(test_list))
    end
  else
    -- print("DEBUG(fn.glob): No test bundles found: " .. test_bundle_pattern)
  end
end

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

  -- on_attach = require("plugins.configs.lsp.lsp_attach").custom_attach,
  -- capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities,
  -- handlers = require("plugins.configs.lsp.lsp_handlers").handlers,

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
      -- Formatting works by default, but you can refer to a specific file/URL if you choose
      -- settings = {
      --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
      --   profile = "GoogleStyle",
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

-- -- Needed for debugging
-- config["on_attach"] = function(client, bufnr)
--   -- Your existing dap setup
--   jdtls.setup_dap { hotcodereplace = "auto" }
--   require("jdtls.dap").setup_dap_main_class_configs()
--   -- Include the original on_attach from your lsp config
--   require("plugins.configs.lsp.lsp_attach").custom_attach(client, bufnr)
--   -- print("Hover supported: ", client.server_capabilities.hoverProvider)
-- end

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
