return function()
  local glance = require 'glance'
  local actions = glance.actions

  glance.setup {
    mappings = {
      list = { ['<Tab>'] = actions.enter_win 'preview' },
      preview = { ['<Tab>'] = actions.enter_win 'list' },
    },
  }
end
