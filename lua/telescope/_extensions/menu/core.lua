local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local config = require "telescope._extensions.menu.config"

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
    .new(opts, {
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
          }, opts)
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_, _)
        actions.select_default:replace(function(prompt_bufnr)
          actions.close(prompt_bufnr)

          local entry = action_state.get_selected_entry()
          entry.action(entry, ctx)
        end)
        return true
      end,
    })
    :find()
end

local M = {}

M.get_menu_launcher = function(menu_name)
  return function(opts)
    return call_picker(vim.tbl_deep_extend("force", { menu_name = menu_name }, opts))
  end
end

return M
