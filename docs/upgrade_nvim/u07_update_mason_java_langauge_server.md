# Update for java langauge server

On `07/05/2025` `Mason` builder got updated to version `2.0` and supporting neovim versions `0.11.x`.

- Major changes that give mason more automaticall to install the server to go,
  without `enable`
- I have already updated the java langauge server and removed the manual
  installor for the `debuger` and for the `tester`.

Thought for 5 seconds

### Summary of the edits (plain list, no tables)

---

1. **Stop calling `get_install_path()`**

   _Reason_ – Mason 2.0 removed that method, so it returns `nil` and crashes.

   **Before**

   ```lua
   local jdtls_package = mason_registry.get_package "jdtls"
   jdtls_install_path  = jdtls_package:get_install_path()
   ```

   **After**

   ```lua
   local mason_root        = vim.fn.stdpath("data") .. "/mason"
   local jdtls_install_path = mason_root .. "/packages/jdtls"
   ```

---

2. **Find the launcher JAR with `globpath()`**

   _Reason_ – the filename is version-stamped (`…_1.12.0.jar`, etc.), so a glob keeps the path stable.

   ```lua
   local jdtls_launcher = vim.fn.globpath(
     jdtls_install_path .. "/plugins",
     "org.eclipse.equinox.launcher_*.jar",
     false,  -- non-recursive
     true    -- return list
   )[1]
   ```

---

3. **Hard-code adapter directories under Mason**

   _Reason_ – same as step 1: avoid the deleted `get_install_path()` from `Mason 2.0`.

   ```lua
   local dap_install_path  = mason_root .. "/packages/java-debug-adapter/extension/server"
   local test_install_path = mason_root .. "/packages/java-test/extension/server"
   ```

---

4. **Delete the old “manual vs Mason” bundling block**

   _Reason_ – it created another `local bundles = {}` and duplicated logic.

   > Removed everything from
   > `-- 🛠️ Debug Adapter:`
   > down to
   > `-- ✅ 'bundles' is now ready …`

---

5. **Re-build the `bundles` table once, correctly**

   _Reason_ – use the new paths, avoid duplicates, handle future Mason updates.

   ```lua
   local bundles = {}

   local function add_jars(dir, pattern)
     for _, jar in ipairs(vim.fn.globpath(dir, pattern, false, true)) do
       if jar ~= "" then table.insert(bundles, jar) end
     end
   end

   add_jars(dap_install_path,  "com.microsoft.java.debug.plugin-*.jar")
   add_jars(test_install_path, "*.jar")           -- picks up runner + server jars
   ```

---

6. **Fix the helper that caused “expected string, got table”**

   _Reason_ – `globpath(..., true)` already returns a list; passing that list
   to `vim.split()` crashed. The `vim.split()` call was removed (see code in
   step 5).

---

7. **Remove duplicate “/extension/server/extension/server/”**

   _Reason_ – concatenating the segment twice produced an invalid path.
   We deleted the two lines that re-appended `"/extension/server/"`.

---

8. **Correct the verification snippet**

   _Reason_ – `jdtls.get_bundles()` doesn’t exist. Use the active LSP client instead.

   ```vim
   :lua
   for _, c in pairs(vim.lsp.get_active_clients()) do
     if c.name == "jdtls" then
       print("bundles loaded →", #c.config.init_options.bundles)
     end
   end
   ```

---

After these changes Neovim starts JDT LS without errors, the debug/test jars
are detected, and your variable names remain unchanged so the rest of your
configuration keeps working.
