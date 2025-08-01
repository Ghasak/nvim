local M = {}
M.config = function()
  local status_ok, gen = pcall(require, "gen")
  if not status_ok then return end
  gen.prompts["Elaborate_Text"] = {
    prompt = "Elaborate the following text:\n$text",
    replace = true,
  }

  gen.prompts["Make_Style"] = {
    prompt = "Transform the following text into the style of $input1: $text",
    replace = true,
  }
  gen.model = "gemma3:27b"
  gen.init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end
end

return M
