----------------------------------------------------------------------------------------------------------------------
-- [Notice] The CMP only requests a lua-file to be associated with the lsp kind icons,  which is lspkind_icons.lua
-- Check for more details:  https://github.com/LunarVim/Neovim-from-scratch/blob/05-completion/lua/user/cmp.lua
----------------------------------------------------------------------------------------------------------------------
local M = {}

--------------------------------------------------------------------
local iconsx = require "plugins.configs.icons"

local function get_icon(name)
  return iconsx.kind[name]
    -- or iconsx.type[name]
    -- or iconsx.ui[name]
    -- or iconsx.git[name]
    -- or iconsx.documents[name]
    -- or iconsx.diagnostics[name]
    or iconsx.misc[name]
    or "?"
end

--------------------------------------------------------------------

function M.setup()

  ---@diagnostic disable-next-line: unused-local
  local types = require "cmp.types"
  local present, cmp = pcall(require, "cmp")

  if not present then return end

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then return end

  require("luasnip/loaders/from_vscode").lazy_load()

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  vim.opt.completeopt = "menuone,noinsert,noselect"
  -- This will link our cmp items to the default ones.
  vim.cmd [[
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

  local icons = require "plugins.configs.icons"
  -- local kind_icons = icons.kind
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#2d333b", bg = "#6CC644" })
  vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#2d333b", bg = "#FDE030" })
  vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#2d333b", bg = "#F64D00" })
  vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#2d333b", bg = "#F0D2D1" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#2d333b", bg = "#B2C9AB" })
  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#2d333b", bg = "#F4D35E" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#2d333b", bg = "#9EA3B0" })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#2d333b", bg = "#D5CFE1" })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#2d333b", bg = "#9BBDF9" })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#2d333b", bg = "#D282A6" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#2d333b", bg = "#6DB7BA" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#2d333b", bg = "#C49E85" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#2d333b", bg = "#E1BB80" })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#2d333b", bg = "#A3BFA8" })
  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#2d333b", bg = "#EEEDBF" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#2d333b", bg = "#D3D5D7" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#2d333b", bg = "#F49FBC" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#2d333b", bg = "#F49FBC" })
  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#2d333b", bg = "#A799B7" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#2d333b", bg = "#BFD7EA" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#2d333b", bg = "#F0F3BD" })
  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#2d333b", bg = "#1A5E63" })
  vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#2d333b", bg = "#F9DAD0" })
  vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#2d333b", bg = "#9FA4A9" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#2d333b", bg = "#C2D3CD" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#2d333b", bg = "#F2DC5D" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#2d333b", bg = "#C2D3CD" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#2d333b", bg = "#DB9065" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#2d333b", bg = "#A4031F" })
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#2d333b", bg = "#9DC0BC" })

  -- TabNine
  local tabnine = require "cmp_tabnine.config"

  -- tabnine:setup { max_lines = 1000, max_num_results = 20, sort = true }

  tabnine:setup {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = {
      -- default is not to ignore
      -- uncomment to ignore in lua:
      -- lua = true
    },
    show_prediction_strength = true,
    min_percent = 0,
  }



  -- nvim-cmp setup
  cmp.setup {
    sources = {
      { name = "nvim_lsp" },
      { name = "vim-dadbod-completion" }, -- Enables Dadbod-based SQL completions
      { name = "luasnip", option = { use_show_condition = false } },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "codeium" },
      -- { name = "ultisnips" },
      -- { name = "vsnip" },
      { name = "cmp_tabnine" , group_index = 2},
      { name = "look" },
      { name = "neorg" },
      { name = "path" },
      { name = "treesitter" },
      { name = "calc" },
      { name = "neosnippet" },
      {
        name = "spell",
        option = {
          keep_all_entries = false,
          enable_in_context = function() return true end,
        },
      },
      { name = "emoji" },
      { name = "crates" },
    },

    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        require("snippy").expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },

    window = {
      documentation = {
        border = "double",
        winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      completion = {
        border = "double",
        winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        side_padding = 0,
      },
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },

      -- ------------------------------------------------------------------------------------

      format = function(entry, vim_item)
        -- Trimming the abbrivation for the functions (text) that will appear.
        vim_item.abbr = vim_item.abbr:match "[^(]+"
        -- Removing the duplicates
        --local kind = vim_item.kind
        --vim_item.kind = " " .. (require("plugins.configs.lspkind_icons").icons[vim_item.kind] or "?") .. " "
        -- vim_item.kind = " " .. (require("plugins.configs.lspkind_icons").icons[vim_item.kind] or "?") .. " "

        vim_item.kind = " " .. get_icon(vim_item.kind) .. " "

        local source = entry.source.name
        vim_item.menu = "(" .. source .. ")"

        -- Specific items
        if entry.source.name == "cmp_tabnine" then
          -- vim_item.kind = icons.misc.Robot .. " Tabnine"
          vim_item.kind = string.format(" %s ", icons.misc.Robot)
          vim_item.kind_hl_group = "CmpItemKindTabnine"
        end
        if entry.source.name == "copilot" then
          vim_item.kind = icons.git.Octoface
          vim_item.kind_hl_group = "CmpItemKindCopilot"
        end

        if entry.source.name == "emoji" then
          vim_item.kind = icons.misc.Smiley
          vim_item.kind_hl_group = "CmpItemKindEmoji"
        end

        if entry.source.name == "crates" then
          vim_item.kind = icons.misc.Package
          vim_item.kind_hl_group = "CmpItemKindCrate"
        end

        vim_item.menu = ({
          -- nvim_lsp = "[LSP]",
          nvim_lsp = "[󰒍 LSP]",
          nvim_lua = "[  Lua]",
          cmp_tabnine = "[  TabNine]",
          buffer = "[﬘  BUF]",
          ultisnips = "[   UltiSnips]",
          name = "[   vsnip]", -- For vsnip users.
          luasnip = "[  LuaSnip]",
          latex_symbols = "[  Latex]",
          neorg = "[  Neorg]",
          look = "[ Look]",
          path = "[  Path]",
          spell = "[󰓆 Spell]", -- This will be trigger once you allow spell-checking using F6, dont use vim.opt.spell = true, as it will be triggered everytime cmp loaded
          calc = "[  Calc]",
          emoji = "[󰞅 Emoji]",
        })[entry.source.name]

        return vim_item
        -- return kind
      end,
      -- ------------------------------------------------------------------------------------
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      --      ["<Tab>"] = function(fallback)
      --         if vim.fn.pumvisible() == 1 then
      --            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
      --         elseif require("luasnip").expand_or_jumpable() then
      --            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      --         else
      --            fallback()
      --         end
      --      end,
      --      ["<S-Tab>"] = function(fallback)
      --         if vim.fn.pumvisible() == 1 then
      --            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
      --         elseif require("luasnip").jumpable(-1) then
      --            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      --         else
      --            fallback()
      --         end
      --      end,
      -- TAB Configuration with the CMP
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
    completion = {
      -- border = "rounded",
      completeopt = "menu,menuone,noinsert",
    },
    experimental = { ghost_text = false, native_menu = false },
  }

  -- Database completion
  -- vim.api.nvim_exec(
  --   [[ autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ]],
  --   false
  -- )

  -- Import the 'cmp' module

  -- Create an autocommand group named 'DadbodCompletion'
  vim.api.nvim_create_augroup("DadbodCompletion", { clear = true })
  -- Define an autocommand for SQL file types
  vim.api.nvim_create_autocmd("FileType", {
    group = "DadbodCompletion",
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
      -- Set up 'nvim-cmp' for the current buffer
      cmp.setup.buffer {
        sources = {
          { name = "vim-dadbod-completion" },
          -- You can add other sources here if needed
        },
      }
    end,
  })

  ----------------------------------------------------------------------------------------------------------------------
  --
  --                            █▀▀ █▀▄▀█ █▀█ ▄▄ █▀▀ █▀▄▀█ █▀▄ █   █ █▄ █ █▀▀
  --                            █▄▄ █ ▀ █ █▀▀    █▄▄ █ ▀ █ █▄▀ █▄▄ █ █ ▀█ ██▄
  --
  ----------------------------------------------------------------------------------------------------------------------
  -- local feedkeys = require("cmp.utils.feedkeys")
  -- local keymap = require("cmp.utils.keymap")
  -- Function used to custom the mapping for the cmdline for both (:) and (\)
  local mapping_custom_fn = function()
    return {
      ["<Tab>"] = {
        c = function()
          if cmp.visible() then
            -- cmp.select_next_item()
            cmp.select_next_item {
              behavior = types.cmp.SelectBehavior.Insert,
            }
          else
            -- feedkeys.call(keymap.t("<C-z>"), "n")
            cmp.complete() -- added for fix the auto complete
          end
        end,
      },
      ["<S-Tab>"] = {
        c = function()
          if cmp.visible() then
            -- cmp.select_prev_item()
            cmp.select_prev_item {
              behavior = types.cmp.SelectBehavior.Insert,
            }
          else
            -- feedkeys.call(keymap.t("<C-z>"), "n")
            cmp.complete() -- added for fix the auto complete
          end
        end,
      },
      ["<C-n>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<C-p>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
    }
  end

  -- Command mode completion
  -- local cmdline_mappings = cmp.mapping.preset.cmdline(filter_mode(mapping, "c"))
  -- local cmdline_view = {entries = "wildmenu"} -- <- If you want to make your cmp menu showed horizontally.
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  ---@diagnostic disable-next-line: missing-fields
  cmp.setup.cmdline({ "/", "?" }, {
    -- mapping = cmp.mapping.preset.cmdline(), -- <- I have borrowed from this function the mapping table below,
    mapping = mapping_custom_fn(),
    -- view = cmdline_view,
    sources = { { name = "buffer" } },
  })
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    -- some_function = cmp.mapping.preset.cmdline(), -- <- I have borrowed from this function the mapping table below,
    mapping = mapping_custom_fn(),
    -- view = cmdline_view,
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  })
end

return M
