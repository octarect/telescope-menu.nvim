local normalize_menu = function(ext_menu_config)
  local menu_config = {}
  local default_action = ext_menu_config.default_action or "command"

  menu_config.results = {}
  for i, item in ipairs(ext_menu_config.items) do
    item.index = i
    item.action = item.action or default_action
    table.insert(menu_config.results, item)
  end

  return menu_config
end

local M = {}

M.config = {}

M.setup = function(ext_config, config)
  M.config.default = normalize_menu(ext_config.default)
end

return M
