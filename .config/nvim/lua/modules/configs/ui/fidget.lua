return function()
  local icons = {
    ui = require('modules.utils.icons').get 'ui',
  }

  require('fidget').setup {
    progress = {
      -- suppress_on_insert = false, -- Suppress new messages while in insert mode
      -- ignore_done_already = false, -- Ignore new tasks that are already complete
      display = {
        render_limit = 5, -- How many LSP messages to show at once
        done_ttl = 2, -- How long a message should persist after completion
        done_icon = icons.ui.Accepted, -- Icon shown when all LSP progress tasks are complete
      },
    },
    notification = {
      override_vim_notify = true,
      configs = {
        default = {
          icon = '',
          name = '',
          debug_annote = '',
          info_annote = '',
          warn_annote = '',
          error_annote = '',
        },
      },
      window = {
        winblend = 0,
        zindex = 75,
      },
    },
  }
end
