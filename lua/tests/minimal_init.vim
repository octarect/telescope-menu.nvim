packloadall

lua << EOF
local telescope = require "telescope"
telescope.setup({
  extensions = {
    menu = {
      default = {
        items = {
          { display = "Check health", value="checkhealth"},
          { action = "command", display = "Find files", value="Telescope find_files"},
        }
      }
    }
  }
})
telescope.load_extension("menu")
EOF
