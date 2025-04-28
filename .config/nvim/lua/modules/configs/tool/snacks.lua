---@module 'snacks'
---@type snacks.Config
return {
  quickfile = {
    exclude = { 'latex' },
  },
  indent = {
    indent = {
      enabled = false,
    },
    animate = {
      enabled = false,
    },
  },
  picker = {
    prompt = '? ',
    ui_select = false,
    layout = 'vscode',
    layouts = {
      vscode = {
        preview = false,
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
      lines = {
        layout = 'vscode',
      },
      git_diff = {
        layout = 'ivy',
      },
      undo = {
        layout = 'ivy',
      },
    },
  },
}
