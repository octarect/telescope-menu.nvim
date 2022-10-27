local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local config = require "telescope._extensions.menu.config"

local menu_actions = {}

menu_actions.command = function(entry)
  vim.api.nvim_exec(entry.value, true)
end

local call_picker = function(opts)
  opts = opts or {}

  local ctx = {}
  ctx.initial_mode = vim.fn.mode()
  ctx.filetype = vim.bo.filetype

  local menu
  if opts.menu_name == "filetype" and type(config.data["filetype"]) == "table" then
    menu = config.data["filetype"][ctx.filetype] or {}
  else
    menu = config.data[opts.menu_name]
  end

  -- values in 2nd arg will be overwritten by opts
  pickers
    .new({}, {
      prompt_title = opts.menu_name,
      finder = finders.new_table {
        results = menu.items or {},
        entry_maker = function(entry)
          return make_entry.set_default_entry_mt({
            value = entry.value,
            display = entry.display,
            ordinal = entry.display,
            -- Additional properties for the plugin
            action = entry.action,
          }, {})
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_, _)
        actions.select_default:replace(function(prompt_bufnr)
          actions.close(prompt_bufnr)

          local entry = action_state.get_selected_entry()
          if menu_actions[entry.action] then
            menu_actions[entry.action](entry, ctx)
          else
            error(string.format("Unknown action: %s", entry.action))
          end
        end)
        return true
      end,
    })
    :find()
end

local M = {}

M.get_menu_launcher = function(menu_name)
  return function()
    return call_picker { menu_name = menu_name }
  end
end

return M
