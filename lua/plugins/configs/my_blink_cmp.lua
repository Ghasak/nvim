-- lua/plugins/configs/blink_cmp.lua
local M = {}

function M.setup()
  -- guard: do nothing if blink.cmp isn’t available
  local ok, blink = pcall(require, "blink.cmp")
  if not ok then return end

  -- always use these completeopt flags
  vim.opt.completeopt = "menuone,noinsert,noselect"

  blink.setup {
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      -- confirm when menu is visible, otherwise insert a newline
      ["<CR>"] = { "select_and_accept", "fallback_to_mappings" },
    },
    completion = {
      menu = {
        border = "double",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        min_width = 15,
        max_height = 10,
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { "s", "n" },
        auto_show = true,
        draw = {
          padding = 0,
          gap = 1,
          cursorline_priority = 10000,
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },

          treesitter = {},
          components = {
            kind_icon = {
              -- always 2 cells wide, icon centered
              -- Copilot = "",
              width = { min = 2, max = 2 },
              ellipsis = false,
              -- text = function(ctx) return ctx.kind_icon .. ctx.icon_gap .. " " end,
              text = function(ctx)
                if ctx.kind == "Copilot" then
                  -- use your Copilot glyph
                  return "󰚩" .. ctx.icon_gap
                end
                -- otherwise fall back to mini.icons
                local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
            },

            -- kind = {
            --   ellipsis = false,
            --   -- (optional) use highlights from mini.icons
            --   highlight = function(ctx)
            --     local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
            --     return hl
            --   end,
            -- },
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx) return ctx.label .. ctx.label_detail end,
              -- highlight = function(ctx)
              --   local hl = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel"
              --   return { { 0, #ctx.label, group = hl } }
              -- end,

              highlight = function(ctx)
                -- label and label details
                local highlights = {
                  { 0, #ctx.label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
                }
                if ctx.label_detail then
                  table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" })
                end
                -- characters matched on the label by the fuzzy matcher
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end

                return highlights
              end,
            },

            label_description = {
              width = { max = 30 },
              text = function(ctx) return ctx.label_description end,
              highlight = "BlinkCmpLabelDescription" or "BlinkCmpLabelDetail",
            },

            source_name = {
              width = { max = 30 },
              -- text = function(ctx) return "[" .. ctx.source_name .. "]" end,
              text = function(ctx)
                local icons = {
                  lsp = "[󰒍 LSP]",
                  nvim_lua = "[  Lua]",
                  cmp_tabnine = "[  TabNine]",
                  buffer = "[﬘  BUF]",
                  ultisnips = "[   UltiSnips]",
                  vsnip = "[   vsnip]",
                  snippets = "[  Snip]", -- ← Friendly-Snippets via snippets provider
                  luasnip = "[  LuaSnip]",
                  latex_symbols = "[  Latex]",
                  neorg = "[󰙹 Neorg]",
                  look = "[ Look]",
                  path = "[ Path]",
                  spell = "[󰓆 Spell]",
                  calc = "[  Calc]",
                  emoji = "[󰞅 Emoji]",
                  copilot = "[󰚩  Copilot]",
                }
                -- ctx.source_id is the key from `sources.providers`
                return icons[ctx.source_id] or ctx.source_name
              end,

              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      documentation = {
        -- keep the docs popup under its `window` key :contentReference[oaicite:2]{index=2}
        auto_show = true,
        auto_show_delay_ms = 200,
        update_delay_ms = 50,
        -- treesitter_highlighting = true,
        window = {
          border = "double",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
          min_width = 10,
          max_width = 80,
          max_height = 20,
          -- Note that the gutter will be disabled when border ~= 'none'
          scrollbar = true,
          -- Which directions to show the documentation window,
          -- for each of the possible menu window directions,
          -- falling back to the next direction when there's not enough space
          direction_priority = {
            menu_north = { "e", "w", "n", "s" },
            menu_south = { "e", "w", "s", "n" },
          },
        },
      },
      -- -- Displays a preview of the selected item on the current line
      -- ghost_text = {
      --   enabled = false,
      --   -- Show the ghost text when an item has been selected
      --   show_with_selection = true,
      --   -- Show the ghost text when no item has been selected, defaulting to the first item
      --   show_without_selection = false,
      --   -- Show the ghost text when the menu is open
      --   show_with_menu = true,
      --   -- Show the ghost text when the menu is closed
      --   show_without_menu = true,
      -- },
    },

    -- signature = {
    --   enabled = true, -- We are using ray-x/lsp_signature.nvim
    --   window = { border = "double" },
    -- },
    fuzzy = {
      sorts = {
        "exact",
        -- defaults
        "score",
        "sort_text",
      },
    },
    -- … your other global blink.cmp options …

    cmdline = {
      enabled = true,
      -- inherit the built-in mappings, then override Tab/Enter:
      keymap = {
        preset = "cmdline",
        ["<Tab>"] = { "accept" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "select_and_accept" },
        ["<C-e>"] = { "cancel" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      -- automatically show the menu in cmdline
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
        -- (you can also re-add your trigger/list overrides here if you like)
      },

      -- dynamic source selection for /, ?, : and @
      sources = function()
        local tp = vim.fn.getcmdtype()
        if tp == "/" or tp == "?" then
          return { "buffer" }
        elseif tp == ":" or tp == "@" then
          return { "path", "cmdline" }
        end
        return {}
      end,
    },

    term = {
      enabled = false,
      keymap = { preset = "default" }, -- Inherits from top level `keymap` config when not set
      sources = {},
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
        },
        -- Inherits from top level config options when not set
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = nil,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = nil,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = nil },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = nil },
      },
    },
    -- per-source overrides live here at top level
    sources = {
      default = { "lsp", "snippets", "copilot", "path", "buffer", "emoji" },
      -- for SQL files only, replace defaults with dadbod
      per_filetype = {
        sql = { "lsp", "snippets", "copilot", "dadbod", "buffer", "emoji" },
      },
      providers = {
        path = {
          opts = {
            get_cwd = function(_) return vim.fn.getcwd() end,
          },
        },
        cmdline = {
          min_keyword_length = function(ctx)
            -- only pop up after 3 chars (and no space typed yet) in :/@ commands
            if ctx.mode == "cmdline" and vim.fn.getcmdtype():match "[%:@]" and not ctx.line:find " " then return 2 end
            return 0
          end,
        },
        -- (other providers…)
        -- ← add this clause for dadbod support
        -- you can also pass any `opts = { … }` here if needed
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        -- tell Blink how to load the emoji source via blink.compat
        emoji = {
          name = "emoji", -- must match the nvim-cmp source name
          module = "blink.compat.source", -- the compat “bridge”
          -- opts = { … }               -- any cmp-emoji–specific opts go here
        },
        copilot = {
          name = "copilot", -- must match the nvim-cmp source
          module = "blink-cmp-copilot", -- <-- tell Blink where to load it from
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },
  }
  -- now override each kind’s highlight group:
  -- after your `blink.setup{…}` call, add:

  local kind_colors = {
    Copilot = "#F49FBC",
    Emoji = "#EEEDBF",
    Crate = "#F64D00",
    Tabnine = "#F0D2D1",
    Class = "#B2C9AB",
    Field = "#F4D35E",
    Keyword = "#9EA3B0",
    Method = "#D5CFE1",
    Variable = "#9BBDF9",
    Function = "#D282A6",
    Constructor = "#6DB7BA",
    Module = "#C49E85",
    Constant = "#E1BB80",
    Snippet = "#A3BFA8",
    Text = "#EEEDBF",
    Struct = "#D3D5D7",
    EnumMember = "#F49FBC",
    Enum = "#F49FBC",
    Interface = "#A799B7",
    Reference = "#BFD7EA",
    Property = "#F0F3BD",
    Unit = "#1A5E63",
    Value = "#F9DAD0",
    Color = "#9FA4A9",
    File = "#C2D3CD",
    Folder = "#C2D3CD",
    Event = "#DB9065",
    Operator = "#A4031F",
    TypeParameter = "#9DC0BC",
  }

  for kind, bg in pairs(kind_colors) do
    vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { fg = "#2d333b", bg = bg })
  end
end
return M
