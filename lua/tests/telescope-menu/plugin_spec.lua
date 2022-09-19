local plugin = require "telescope-menu"

describe("plugin", function()
  it("can parse valid config correctly", function()
    local input = {
      default = {
        items = {
          { action = "command", display = "text00", value = "value00" },
          { action = "command", display = "text01", value = "value01" },
        },
      },
    }

    local expected = {
      default = {
        results = {
          { index = 1, action = "command", display = "text00", value = "value00" },
          { index = 2, action = "command", display = "text01", value = "value01" },
        },
      },
    }

    assert.has_no.error(function()
      plugin.setup(input, {})
    end)

    assert.same(plugin.config, expected)
  end)
end)
