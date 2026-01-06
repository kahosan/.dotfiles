---@module 'snacks'
---@type snacks.Config
return {
  bigfile = {
    enabled = require('core.settings').load_big_files_faster,
    notify = false,
  },
  quickfile = {
    exclude = { 'latex' },
  },
  terminal = {},
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
    layout = 'vscode',
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
      lines = { layout = 'vscode' },
      git_diff = { layout = 'ivy' },
      undo = { layout = 'ivy' },
      grep = { layout = 'ivy' },
      grep_buffers = { layout = 'ivy' },
      grep_word = { layout = 'ivy' },
    },
  },
}
