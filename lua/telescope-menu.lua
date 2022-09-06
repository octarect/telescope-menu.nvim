local make_results = function(items)
  local results = {}
  for i, item in ipairs(items) do
    local r = item
    r.index = i
    table.insert(results, r)
  end
  return results
end

local M = {}

M.config = {}

M.setup = function(ext_config, config)
  M.config.global = {}
  M.config.global.results = make_results(ext_config.global.items)
end

return M
