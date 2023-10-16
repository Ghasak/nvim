local M = {}
M.config = function()
  local status_ok, gen = pcall(require, "gen")
  if not status_ok then
    return
  end
  gen.prompts["Elaborate_Text"] = {
    prompt = "Elaborate the following text:\n$text",
    replace = true,
  }

  gen.prompts["Make_Style"] = {
    prompt = "Transform the following text into the style of $input1: $text",
    replace = true,
  }
  gen.model = 'zephyr'
end

return M
