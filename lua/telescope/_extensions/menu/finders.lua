local finders = require "telescope.finders"
local config = require "telescope._extensions.menu.config".data
local make_entry = require "telescope.make_entry"

local M = {}

M.default = function(opts)
  return finders.new_table {
    results = config.default.items,
    entry_maker = function(entry)
      return make_entry.set_default_entry_mt({
        value = entry.value,
        display = entry.display,
        ordinal = entry.display,
        -- Additional properties for the plugin
        action = entry.action,
      }, opts)
    end,
  }
end

return M
