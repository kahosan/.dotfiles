return function()
  local icons = {
    ui = require('modules.utils.icons').get 'ui',
    misc = require('modules.utils.icons').get 'misc',
    cmp = require('modules.utils.icons').get('cmp', true),
  }

  require('which-key').setup {
    preset = 'classic',
    delay = 0,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        motions = false,
        operators = false,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      -- border = CUSTOM_BORDER,
      padding = { 1, 2 },
      wo = { winblend = 0 },
    },
    expand = 1,
    icons = {
      group = '',
      rules = false,
      colors = false,
      breadcrumb = icons.ui.Separator,
      separator = icons.misc.Vbar,
      keys = {
        C = 'C-',
        M = 'A-',
        S = 'S-',
        BS = '<BS> ',
        CR = '<CR> ',
        NL = '<NL> ',
        Esc = '<Esc> ',
        Tab = '<Tab> ',
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        Space = '<Space> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
      },
    },
  }
end
