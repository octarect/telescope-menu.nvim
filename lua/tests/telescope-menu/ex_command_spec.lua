-- setup
(function()
  local telescope = require "telescope"
  telescope.setup {
    extensions = {
      menu = {
        default = {
          items = {
            { display = "Check health", value = "checkhealth" },
            { action = "command", display = "Find files", value = "Telescope find_files" },
          },
        },
        menu2 = {},
        filetype = {
          lua = {
            items = {
              { display = "Format", value = "!stylua %" },
            },
          },
        },
      },
    },
  }
  telescope.load_extension "menu"
end)()

describe("integration tests:", function()
  it("Telescope menu", function()
    vim.cmd [[ Telescope menu ]]
  end)

  it("check mutiple menu support", function()
    vim.cmd [[ Telescope menu menu2 ]]
  end)

  it("Open menu depending on filetype", function()
    vim.cmd [[ Telescope menu filetype ]]
  end)
end)
