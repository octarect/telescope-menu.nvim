local core = require "telescope._extensions.menu.core"
local config = require "telescope._extensions.menu.config"

return require("telescope").register_extension {
  setup = config.setup,
  exports = {
    menu = core.menu,
    default = core.menu,
  },
}
