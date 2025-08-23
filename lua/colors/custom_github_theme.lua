local M = {}

M.palettes = {
  -- Everything defined under `all` will be applied to each style.
  -- all = {
  --   -- Each palette defines these colors:
  --   --   black, gray, blue, green, magenta, pink, red, white, yellow, cyan
  --   -- These colors have 2 shades: base, and bright
  --   -- Passing a string sets the base
  --   red = "#8e1519",
  --   },
  --
  -- github_dark = {
  --   -- Defining multiple shades is done by passing a table
  --   bg1 = "#2e3a40", -- pick your new background here
  --   red = {
  --     base = "#8e1519",
  --     bright = "#8e1519",
  --   },
  -- },
  --
  -- github_light = {
  --   -- Defining multiple shades is done by passing a table
  --   bg0 = "#2e3a40", -- pick your new background here
  --   -- red = "#cd2731" ,
  --   -- blue = {base = "#0853ae", bright = "#87d9fe"},
  -- },
}



M.specs = {
  -- As with palettes, the values defined under `all` will be applied to every style.
  all = {
    syntax = {
      -- Specs allow you to define a value using either a color or template. If the string does
      -- start with `#` the string will be used as the path of the palette table. Defining just
      -- a color uses the base version of that color.
      --  **@variable**
      --  **@function.call**
      --  **@function.builtin**

      -- Adding either `.bright` will change the value
      -- conditional = "magenta.bright",
    },
  },
  github_dark = {
    syntax = {
      builtin0 = "fg1",
      keyword = "#fc6e68",
      func = "#95d1fe",
      number = "#95d1fe",
      type = "#f9ae82",
      -- if you’d rather target the Tree-sitter calls separately:
      ["@function.call"] = { fg = "#95d1fe" },
      -- and function definitions explicitly:
      ["@function"] = { fg = "#4ca9ec" },
      ["@constant.builtin"] = { fg = "#ebebb9" },
      -- As with palettes, a specific style's value will be used over the `all`'s value.
      operator = "orange",
    },
  },

  github_light = {
    syntax = {
      builtin0 = "fg1",
      -- keyword = "#fc6e68",
      func = "#0853ae",
      number = "#0853ae",
      -- type = "#f9ae82",
      -- if you’d rather target the Tree-sitter calls separately:
      -- ["@function.call"] = { fg = "#95d1fe" },
      -- and function definitions explicitly:
      ["@function"] = { fg = "#0853ae" },
      -- As with palettes, a specific style's value will be used over the `all`'s value.
      -- operator = "orange",
    },
  },
}

M.groups = {

  -- As with specs and palettes, the values defined under `all` will be applied to every style.
  all = {
    -- If `link` is defined it will be applied over any other values defined
    Whitespace = { link = "Comment" },
    -- Specs are used for the template. Specs have their palette's as a field that can be accessed
    -- IncSearch = { bg = "palette.cyan" },
  },
  github_dark = {
    -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
    PmenuSel = { bg = "#4ca9ec", fg = "bg1" },
    Pmenu = { fg = "fg1", bg = "bg1" },
    FloatBorder = { fg = "fg1", bg = "bg1" },
    StatusLine = {}, -- status line of current window
    StatusLineNC = {}, -- status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
  },

  github_light = {
    -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
    -- PmenuSel = { bg = "#4ca9ec", fg = "bg0" },
    -- Pmenu = { fg = "fg1", bg = "bg1" },
    -- FloatBorder = { bg = "bg0", fg = "fg1" },
    FloatBorder = { fg = "#2e3a40", bg = "bg1" },
    StatusLine = {}, -- status line of current window
    StatusLineNC = {}, -- status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
  },
}

return M




