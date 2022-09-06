local core = require "telescope._extensions.menu.core"
local plugin = require "telescope-menu"

return require("telescope").register_extension {
  setup = plugin.setup,
  exports = {
    menu = core.menu,
    global = core.menu,
  },
}
