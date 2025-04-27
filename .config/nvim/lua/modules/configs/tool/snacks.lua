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
    },
    sources = {
      lines = {
        layout = 'vscode',
      },
      undo = {
        layout = 'ivy',
      },
    },
  },
}

-- vscode = {
--     layout = {
--         backdrop = false,
--         row = 4,
--         width = 0.5,
--         min_width = 100,
--         height = 0.4,
--         border = "none",
--         box = "vertical",
--         { win = "input", height = 1, border = { "┌", "─", "┐", "│", "", "", "", "│" } },
--         { win = "list", border = { "├", "─", "┤", "│", "┘", "─", "└", "│" } },
--     },
-- },
--
