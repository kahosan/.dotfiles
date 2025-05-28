return function()
  local transparent_background = require('core.settings').transparent_background

  require('catppuccin').setup {
    background = { light = 'latte', dark = 'mocha' },
    dim_inactive = {
      enabled = false,
      -- Dim inactive splits/windows/buffers.
      -- NOT recommended if you use old palette (a.k.a., mocha).
      shade = 'dark',
      percentage = 0.15,
    },
    transparent_background = transparent_background,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true,
    no_bold = true, -- Force no bold
    compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
    styles = {
      comments = { 'italic' },
      functions = { 'bold' },
      keywords = { 'italic' },
      operators = { 'bold' },
      conditionals = { 'bold' },
      loops = { 'bold' },
      booleans = { 'bold', 'italic' },
      numbers = {},
      types = {},
      strings = {},
      variables = {},
      properties = {},
    },
    integrations = {
      snacks = {
        enabled = true,
        indent_scope_color = 'blue',
      },
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        -- underlines = {
        --   errors = { 'undercurl' },
        --   hints = { 'undercurl' },
        --   warnings = { 'undercurl' },
        --   information = { 'undercurl' },
        -- },
      },
      aerial = false,
      alpha = true,
      cmp = false,
      blink_cmp = true,
      nvim_surround = true,
      diffview = true,
      fidget = true,
      gitgutter = false,
      gitsigns = true,
      illuminate = true,
      indent_blankline = { enabled = true, colored_indent_levels = false },
      lsp_trouble = false,
      markdown = false,
      mason = true,
      mini = { enabled = false, indentscope_color = '' },
      neotree = true,
      noice = false,
      render_markdown = false,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = { enabled = false, style = 'nvchad' },
      treesitter_context = true,
      which_key = true,
    },
    color_overrides = {
      mocha = {
        base = '#181818',
        mantle = '#212121',
        crust = '#45475a',
      },
    },
    highlight_overrides = {
      all = function(cp)
        return {
          ReactiveCursor = { bg = '#FEFF00' },
          LineNrAbove = { fg = cp.surface1 },
          LineNr = { fg = cp.yellow },
          LineNrBelow = { fg = cp.surface1 },

          TabLineSel = { bg = '#45475b', fg = '#a6e3a2' },
          DiagnosticHint = { fg = '#d0a9e5' },
          DiagnosticUnderlineHint = { sp = '#d0a9e5' },
          LspDiagnosticsUnderlineHint = { sp = '#d0a9e5' },
          SnacksPickerInputBorder = { bg = cp.mantle },
          CodeiumSuggestion = { fg = '#808080' },

          CompileModeMessageRow = { fg = cp.text },
          CompileModeMessageCol = { fg = cp.text },
          CompileModeError = { fg = cp.red },
          CompileModeWarning = { fg = cp.yellow },
          CompileModeInfo = { fg = cp.green },
          CompileModeMessage = { link = 'CompileModeInfo' },
          CompileModeCommandOutput = { fg = '#6699ff' },
          CompileModeDirectoryMessage = { fg = '#6699ff' },
          CompileModeOutputFile = { fg = '#9966cc' },
          CompileModeCheckResult = { fg = '#ff9966' },
          CompileModeCheckTarget = { fg = '#ff9966' },
        }
      end,
    },
  }
end
