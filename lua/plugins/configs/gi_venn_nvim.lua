local M = {}

M.config = function()
  -- require"venn".set_line({ "s", "s" , " ", " " }, '|')
  -- require"venn".set_line({ " ", "s" , " ", "s" }, '+')
  -- require"venn".set_line({ "s", " " , " ", "s" }, '+')
  -- require"venn".set_line({ " ", "s" , "s", " " }, '+')
  -- require"venn".set_line({ "s", " " , "s", " " }, '+')
  -- require"venn".set_line({ " ", "s" , "s", "s" }, '+')
  -- require"venn".set_line({ "s", " " , "s", "s" }, '+')
  -- require"venn".set_line({ "s", "s" , " ", "s" }, '+')
  -- require"venn".set_line({ "s", "s" , "s", " " }, '+')
  -- require"venn".set_line({ " ", " " , "s", "s" }, '-')
  require("venn").set_arrow("up", "▲")
  require("venn").set_arrow("down", "▼")
  require("venn").set_arrow("left", "◀")
  require("venn").set_arrow("right", "▶")

  --   ▲
  -- ◀   ▶
  --   ▼
end
return M
