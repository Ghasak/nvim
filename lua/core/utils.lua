local M = {}
local merge_tb = vim.tbl_deep_extend

-- M.load_config = function()
--   config = {}
-- end

M.remove_disabled_keys = function(chadrc_mappings, default_mappings)
  if not chadrc_mappings then
    return default_mappings
  end

  -- store keys in a array with true value to compare
  local keys_to_disable = {}
  for _, mappings in pairs(chadrc_mappings) do
    for mode, section_keys in pairs(mappings) do
      if not keys_to_disable[mode] then
        keys_to_disable[mode] = {}
      end
      section_keys = (type(section_keys) == "table" and section_keys) or {}
      for k, _ in pairs(section_keys) do
        keys_to_disable[mode][k] = true
      end
    end
  end

  -- make a copy as we need to modify default_mappings
  for section_name, section_mappings in pairs(default_mappings) do
    for mode, mode_mappings in pairs(section_mappings) do
      mode_mappings = (type(mode_mappings) == "table" and mode_mappings) or {}
      for k, _ in pairs(mode_mappings) do
        -- if key if found then remove from default_mappings
        if keys_to_disable[mode] and keys_to_disable[mode][k] then
          default_mappings[section_name][mode][k] = nil
        end
      end
    end
  end

  return default_mappings
end

M.load_mappings = function(section, mapping_opt)
  vim.schedule(function()
    ---@diagnostic disable-next-line: unused-local, unused-function
    local function set_section_map(section_values)
      if section_values.plugin then
        return
      end

      section_values.plugin = nil

      for mode, mode_values in pairs(section_values) do
        local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
        for keybind, mapping_info in pairs(mode_values) do
          -- merge default + user opts
          local opts = merge_tb("force", default_opts, mapping_info.opts or {})

          mapping_info.opts, opts.mode = nil, nil
          opts.desc = mapping_info[2]

          vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
      end
    end
    ---@diagnostic disable-next-line: empty-block
    if type(section) == "string" then
    end
  end)
end

local exclude_files = { "NvimTree_1", "[lazy]", "" }
local function is_excluded_file(file)
  for _, v in ipairs(exclude_files) do
    if v == file then
      return true
    end
  end
  return false
end

local function load_plugin(plugin)
  require("lazy").load { plugins = plugin }

  if plugin == "nvim-lspconfig" then
    vim.cmd "silent! do FileType"
  end
end

local function deferred_load_plugin(plugin)
  vim.schedule(function()
    load_plugin(plugin)
  end, 0)
end

M.lazy_load = function(plugin)
  if not plugin or plugin == "" then
    return
  end -- Ensure plugin parameter is valid

  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),

    callback = function()
      local file = vim.fn.expand "%"

      if not is_excluded_file(file) then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        if plugin == "nvim-treesitter" then
          load_plugin(plugin)
        else
          deferred_load_plugin(plugin)
        end
      end
    end,
  })
end
-- Keymapping function
M.keymapping = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.load_module = function(mod_name)
  local ok, err = pcall(require, mod_name)
  if not ok then
    local msg = "failed loading: " .. mod_name .. "\n " .. err
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

return M
