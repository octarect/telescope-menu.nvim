local normalize_menu = function(ext_menu_config)
  local menu_config = {}
  local default_action = ext_menu_config.default_action or "command"

  menu_config.items = {}
  for i, item in ipairs(ext_menu_config.items) do
    local items0 = {}
    items0.index = i
    items0.action = item.action or item[3] or default_action
    items0.display = item.display or item[1]
    items0.value = item.value or item[2]
    table.insert(menu_config.items, items0)
  end

  return menu_config
end

local M = {}

M.config = {}

M.setup = function(ext_config, _)
  M.config.default = normalize_menu(ext_config.default)
end

return M
