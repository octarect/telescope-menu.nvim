local normalize_menu = function(ext_menu_config)
  local menu_config = {}
  local default_action = ext_menu_config.default_action or "command"

  menu_config.results = {}
  for i, item in ipairs(ext_menu_config.items) do
    local result = {}
    result.index = i
    result.action = item.action or item[3] or default_action
    result.display = item.display or item[1]
    result.value = item.value or item[2]
    table.insert(menu_config.results, result)
  end

  return menu_config
end

local M = {}

M.config = {}

M.setup = function(ext_config, _)
  M.config.default = normalize_menu(ext_config.default)
end

return M
