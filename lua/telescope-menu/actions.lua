local M = {}

M.vim_command = function(entry, _)
  vim.api.nvim_exec(entry.value, true)
end

M.lua_function = function(entry, _)
  entry.value()
end

M.keymap = function(entry, ctx)
  local map = entry.value or ""
  local internal_rep = vim.api.nvim_replace_termcodes(map, true, false, true)
  vim.api.nvim_feedkeys(internal_rep, "t", true)
end

return M
