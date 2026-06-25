---@module 'snacks'
---@type snacks.Config
return {
  quickfile = {
    exclude = { 'latex' },
  },
  terminal = {
    shell = 'fish --private',
    win = {
      keys = {
        term_normal = {
          '<esc>',
          '<C-\\><C-n>',
          mode = 't',
          desc = 'Escape to normal mode',
        },
      },
    },
  },
  indent = {
    indent = {
      char = '┊',
      enabled = true,
    },
    animate = {
      enabled = false,
    },
    scope = {
      -- char = '┊',
    },
  },
  picker = {
    prompt = '? ',
    ui_select = false,
    win = {
      input = {
        keys = {
          ['<c-n>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
          ['<c-p>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
        },
      },
    },
    previewers = {
      diff = {
        style = 'syntax', ---@type "fancy"|"syntax"|"terminal"
      },
    },
    layout = 'ivy_nop',
    layouts = {
      vscode = {
        preview = nil,
        layout = {
          backdrop = false,
          row = 1,
          width = 0.4,
          min_width = 80,
          height = 0.4,
          border = 'none',
          box = 'vertical',
          {
            win = 'input',
            height = 1,
            border = CUSTOM_BORDER,
            title = '{title} {live} {flags}',
            title_pos = 'center',
          },
          { win = 'list', border = 'none' },
          { win = 'preview', title = '{preview}', border = 'none' },
        },
      },
      ivy_nop = {
        layout = {
          box = 'vertical',
          backdrop = false,
          row = -1,
          width = 0,
          height = 0.4,
          border = 'none',
          title = ' {title} {live} {flags}',
          title_pos = 'left',
          { win = 'input', height = 1, border = CUSTOM_BORDER },
          {
            win = 'list',
            border = 'none',
          },
        },
      },
      ivy = {
        layout = {
          box = 'vertical',
          backdrop = false,
          row = -1,
          width = 0,
          height = 0.4,
          border = 'none',
          title = ' {title} {live} {flags}',
          title_pos = 'left',
          { win = 'input', height = 1, border = CUSTOM_BORDER },
          {
            box = 'horizontal',
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
          },
        },
      },
    },
    sources = {
      git_diff = { layout = 'ivy' },
      undo = {
        layout = 'ivy',
        win = {
          input = {
            keys = {
              ['<c-d>'] = { 'undo_diff_current', mode = { 'i', 'n' } },
              D = { 'undo_diff_current', mode = 'n' },
            },
          },
          list = {
            keys = {
              ['<c-d>'] = 'undo_diff_current',
              D = 'undo_diff_current',
            },
          },
        },
        actions = {
          undo_diff_current = require('modules.utils.snacks_undo').diff_current,
        },
      },
      grep = { layout = 'ivy' },
      grep_buffers = { layout = 'ivy_nop' },
      grep_word = { layout = 'ivy_nop' },
    },
  },
}
