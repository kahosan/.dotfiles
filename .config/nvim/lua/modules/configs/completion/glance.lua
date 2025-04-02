return function()
  local glance = require 'glance'
  local actions = glance.actions

  glance.setup {
    mappings = {
      list = { ['<leader>j'] = actions.enter_win 'preview' },
      preview = { ['<leader>j'] = actions.enter_win 'list' },
    },
  }
end
