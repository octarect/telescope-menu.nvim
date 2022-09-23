local plugin = require "telescope-menu"

describe("plugin", function()
  it("can parse valid config correctly", function()
    local input = {
      default = {
        items = {
          { display = "text00", value = "command00" },
          { action = "command", display = "text01", value = "command01" },
          { "text02", "command02" },
          { "text03", "command03", "command" },
          { "text04", "command04", action = "command" },
        },
      },
    }

    local expected = {
      default = {
        items = {
          { index = 1, action = "command", display = "text00", value = "command00" },
          { index = 2, action = "command", display = "text01", value = "command01" },
          { index = 3, action = "command", display = "text02", value = "command02" },
          { index = 4, action = "command", display = "text03", value = "command03" },
          { index = 5, action = "command", display = "text04", value = "command04" },
        },
      },
    }

    assert.has_no.error(function()
      plugin.setup(input, {})
    end)

    assert.same(plugin.config, expected)
  end)
end)
