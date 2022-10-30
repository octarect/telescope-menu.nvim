local actions = require "telescope._extensions.menu.actions"

local function get_default_action(item)
  if type(item.value) == "function" then
    return actions.lua_function
  end
  return actions.vim_command
end

local function normalize_menu(ext_menu_config)
  local menu_config = {}

  menu_config.items = {}
  for i, item in ipairs(ext_menu_config.items or {}) do
    local item0 = {}
    item0.index = i
    item0.display = item.display or item[1]
    item0.value = item.value or item[2]
    item0.action = item.action or item[3] or ext_menu_config.default_action or get_default_action(item0)
    table.insert(menu_config.items, item0)
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
