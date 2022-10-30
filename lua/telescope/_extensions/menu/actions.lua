local M = {}

M.vim_command = function(entry, _)
  vim.api.nvim_exec(entry.value, true)
end

M.lua_function = function(entry, _)
  entry.value()
end

return M
