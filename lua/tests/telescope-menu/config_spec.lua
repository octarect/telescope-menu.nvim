local actions = require "telescope-menu.actions"
local config = require "telescope._extensions.menu.config"
local helpers = require "tests.helpers"

describe("config", function()
  it("items", function()
    local foo_func = function() end
    local foo_action = function(_, _) end
    local input = {
      default = {
        items = {
          { display = "text00", value = "command00" },
          { action = foo_action, display = "text01", value = "command01" },
          { "text02", "command02" },
          { "text03", "command03", foo_action },
          { "text04", "command04", action = foo_action },
          -- function value
          { "text05", foo_func },
        },
      },
    }

    local expected = {
      default = {
        items = {
          { index = 1, action = actions.vim_command, display = "text00", value = "command00" },
          { index = 2, action = foo_action, display = "text01", value = "command01" },
          { index = 3, action = actions.vim_command, display = "text02", value = "command02" },
          { index = 4, action = foo_action, display = "text03", value = "command03" },
          { index = 5, action = foo_action, display = "text04", value = "command04" },
          { index = 6, action = actions.lua_function, display = "text05", value = foo_func },
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
