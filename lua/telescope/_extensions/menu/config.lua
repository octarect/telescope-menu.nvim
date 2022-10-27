local function normalize_menu(ext_menu_config)
  local menu_config = {}
  local default_action = ext_menu_config.default_action or "command"

  menu_config.items = {}
  for i, item in ipairs(ext_menu_config.items or {}) do
    local items0 = {}
    items0.index = i
    items0.action = item.action or item[3] or default_action
    items0.display = item.display or item[1]
    items0.value = item.value or item[2]
    table.insert(menu_config.items, items0)
  end

  return menu_config
end

local function parse_config(ext_config)
  local result = {}
  for name, menu in pairs(ext_config) do
    if name == "filetype" then
      result[name] = parse_config(menu)
    else
      result[name] = normalize_menu(menu)
    end
  end
  return result
end

local M = {}

M.data = {}

M.setup = function(ext_config)
  M.data = parse_config(ext_config)
end

return M
