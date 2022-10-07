local core = require "telescope._extensions.menu.core"
local config = require "telescope._extensions.menu.config"

local extension
extension = require("telescope").register_extension {
  setup = function(ext_config, _)
    config.setup(ext_config)
    for k, _ in pairs(config.data) do
      extension.exports[k] = core.get_menu_launcher(k)
    end
  end,
  exports = {
    menu = core.get_menu_launcher("default"),
    default = core.get_menu_launcher("default"),
  },
}

return extension
