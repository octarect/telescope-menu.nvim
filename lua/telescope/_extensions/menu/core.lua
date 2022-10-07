local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope._extensions.menu.finders"

local default_opts = {
  prompt_title = "Menu1",
}

local menu_actions = {}

menu_actions.command = function(entry)
  vim.api.nvim_exec(entry.value, true)
end

local call_picker = function(opts)
  opts = opts or {}

  local ctx = {}
  ctx.initial_mode = vim.fn.mode()

  -- values in 2nd arg will be overwritten by opts
  pickers
    .new(opts, {
      prompt_title = opts.menu_name,
      finder = finders.default(opts),
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
    return call_picker({ menu_name = menu_name })
  end
end

return M
