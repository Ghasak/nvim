local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "#1e222a"})
    local packer_bootstrap = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    -- Adding first the packer plugin to handle itself
    vim.cmd('packadd packer.nvim')
    -- Adding now the plugins file (list of all plugins to be installted at startup)
    require("plugins.packerPluginsManager")
    -- Adding here the sync command to make packer sync all plugins autoamtically at startup only.
    vim.cmd "PackerSync"
    -- command to be shown when all components are installed.
    vim.cmd [[autocmd User PackerComplete ++once echo "Ready!" ]]
end

