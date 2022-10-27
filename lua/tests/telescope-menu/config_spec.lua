local config = require "telescope._extensions.menu.config"
local helpers = require "tests.helpers"

describe("config", function()
  it("items", function()
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
      config.setup(input)
    end)

    assert.same(config.data, expected)
  end)

  it("multiple menu", function()
    local input = {
      default = {},
      another = {},
    }

    assert.has_no.error(function()
      config.setup(input)
    end)

    -- check config keys
    assert.is_same(helpers.get_keys(input), helpers.get_keys(config.data))
  end)

  it("filetype", function()
    local input = {
      filetype = {
        lua = {},
        vim = {},
      },
    }

    assert.has_no.error(function()
      config.setup(input)
    end)

    -- check config keys
    -- expect the following;
    -- {
    --   filetype = {
    --     lua = {
    --       items = {},
    --     },
    --     vim = { ... },
    --   }
    -- }
    assert.is_true(config.data.filetype ~= nil)
    assert.is_same(helpers.get_keys(input.filetype), helpers.get_keys(config.data.filetype))
  end)
end)
