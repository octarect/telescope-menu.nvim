local M = {}

M.get_keys = function(tbl)
  keys = {}
  for k, _ in pairs(tbl) do
    table.insert(keys, k)
  end
  return keys
end

return M
