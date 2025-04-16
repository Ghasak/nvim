local jdtls = require "jdtls"
local home = os.getenv "HOME"

-- Path to Java 17+ (Adjust if necessary)
-- local java_17_plus_home = home .. "/.sdkman/candidates/java/17.0.10-tem"
-- local java_17_plus_home = home .. "/.sdkman/candidates/java/17.0.10-zulu"
local java_17_plus_home = home .. "/.sdkman/candidates/java/21.0.2-zulu"

local workspace_dir = home .. "/.cache/jdtls-workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

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
    "ERROR(fn.glob): Could not find jdtls launcher JAR using pattern: "
      .. launcher_glob_pattern
      .. " (Check Mason jdtls installation?)",
    vim.log.levels.ERROR
  )
  return -- Stop config execution if launcher not found
end

-- Split the result string into a table (list)
local launcher_glob_list = vim.split(launcher_glob_result_str, "\n")
-- print("DEBUG(fn.glob): Split launcher results: " .. vim.inspect(launcher_glob_list))

if #launcher_glob_list == 0 then
  vim.notify(
    "ERROR(fn.glob): Split glob result was empty for launcher pattern: " .. launcher_glob_pattern,
    vim.log.levels.ERROR
  )
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
local bundles = {} -- Initialize empty table for bundles

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
    java_17_plus_home .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    -- "-Xms1g",
    -- "--add-modules=ALL-SYSTEM",
    -- "--add-opens",
    -- "java.base/java.util=ALL-UNNAMED",
    -- "--add-opens",
    -- "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    jdtls_launcher,
    "-configuration",
    jdtls_install_path .. "/config_" .. (vim.fn.has "mac" == 1 and "mac" or "linux"),
    "-data",
    workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  on_attach = require("plugins.configs.lsp.lsp_attach").custom_attach,
  capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities,
  handlers = require("plugins.configs.lsp.lsp_handlers").handlers,
  settings = {
    java = {
      home = java_17_plus_home,
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = { { name = "JavaSE-17", path = java_17_plus_home } }, -- Configure other JDKs if needed
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
    },
    signatureHelp = { enabled = true },
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
  },
  init_options = {
    bundles = bundles, -- Pass the collected bundles for debug adapter, etc.
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

-- Start the jdtls language server
jdtls.start_or_attach(config)

-- -- Add keymaps specific to Java/jdtls after attach (optional, but useful)
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspJavaSettings", { clear = true }),
--   pattern = "*.java",
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client and client.name == "jdtls" then
--       vim.keymap.set(
--         "n",
--         "<leader>co",
--         jdtls.organize_imports,
--         { buffer = args.buf, desc = "JDTLS Organize Imports" }
--       )
--       vim.keymap.set(
--         "n",
--         "<leader>cv",
--         jdtls.extract_variable,
--         { buffer = args.buf, desc = "JDTLS Extract Variable" }
--       )
--       vim.keymap.set("v", "<leader>cv", function()
--         jdtls.extract_variable(true)
--       end, { buffer = args.buf, desc = "JDTLS Extract Variable (Visual)" })
--       vim.keymap.set(
--         "n",
--         "<leader>cc",
--         jdtls.extract_constant,
--         { buffer = args.buf, desc = "JDTLS Extract Constant" }
--       )
--       vim.keymap.set("v", "<leader>cc", function()
--         jdtls.extract_constant(true)
--       end, { buffer = args.buf, desc = "JDTLS Extract Constant (Visual)" })
--       vim.keymap.set("v", "<leader>cm", function()
--         jdtls.extract_method(true)
--       end, { buffer = args.buf, desc = "JDTLS Extract Method (Visual)" })
--       vim.keymap.set("n", "<leader>djc", function()
--         jdtls.compile()
--       end, { buffer = args.buf, desc = "JDTLS Compile" })
--       vim.keymap.set("n", "<leader>djt", function()
--         jdtls.test_class()
--       end, { buffer = args.buf, desc = "JDTLS Debug Test Class" })
--       vim.keymap.set("n", "<leader>djm", function()
--         jdtls.test_nearest_method()
--       end, { buffer = args.buf, desc = "JDTLS Debug Test Method" })
--       require("jdtls.dap").setup_dap_main_class_configs()
--     end
--   end,
-- })
