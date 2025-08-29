local M = {}

M.get_keys = function(tbl)
  local keys = {}
  for k, _ in pairs(tbl) do
    table.insert(keys, k)
  end
  table.sort(keys)
  return keys
end

return M
