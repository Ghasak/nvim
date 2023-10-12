# Helper fnction

The following function supposes to detect if the list of packages are altered
then the packer.nvim will be trigger automatically. It certainly don't need, as
we have already implmentations in `nvim v.0.8`.

```lua

install_paths = {
  vim.fn.stdpath('data')..'/site/pack/packer/start',
  vim.fn.stdpath('data')..'/site/pack/packer/opt'
}
missing_plugins = {}

function is_file_exists(path)
  local ok, err, code = os.rename(path, path)
  if not ok then
    -- Permission denied, but it exists
    if code == 13 then return true end
  end
  return ok, err
end

get_plugin_entry_split_name = function(entry)
  local full_name = nil
  if type(entry) == 'string' then
    full_name = entry
  elseif type(entry) == 'table' then
    full_name = entry[1]
  end
  return vim.split(full_name, '/')
end
is_plugin_installed = function(short_name)
  for _, path in pairs(install_paths) do
    if is_file_exists(path..'/'..short_name) then
      return true
    end
  end
  return false
end
-- the enteries argument is basically a table of plugins that you'd normally pass to packer.use
-- {
--  'fedepujol/move.nvim',
--  {'rktjmp/paperplanes.nvim',                         branch = 'rel-0.1.2' },
--  {'hrsh7th/nvim-cmp',                                requires = {
--    {'hrsh7th/cmp-buffer'},
--    {'hrsh7th/cmp-path'},
--    {'hrsh7th/cmp-nvim-lsp'},
--    {'hrsh7th/cmp-nvim-lua'},
--  }},
-- }
-- currently this doesn't work with required plugins, only the main ones
detect_missing_plugins = function(entries)
  for _, entry in pairs(entries) do
    --- extract short name
    local name_split = get_plugin_entry_split_name(entry)
    local name_short = name_split[#name_split]
    --- detect if plugin is not installed
    if not is_plugin_installed(name_short) then
      table.insert(missing_plugins, name_short)
    end
  end
end
--  if #missing_plugins > 0 then
--    tell packer to sync
--  end
```

## REFERENCES

- [nvim with lua](https://dpaste.org/NN2Tu/slim#L1,2,4,8,11,13,22,28,46,49,50,54)
