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
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
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
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
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
      lsp_trouble = true,
      markdown = false,
      mason = true,
      mini = { enabled = true, indentscope_color = '' },
      neotree = true,
      noice = false,
      render_markdown = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = { enabled = true, style = 'nvchad' },
      treesitter_context = true,
      which_key = true,
    },
    color_overrides = {},
    highlight_overrides = {
      all = function(cp)
        return {
          TabLineSel = { bg = '#45475b', fg = '#a6e3a2' },
          DiagnosticVirtualTextError = { bg = cp.none },
          DiagnosticVirtualTextHint = { bg = cp.none },
          DiagnosticVirtualTextInfo = { bg = cp.none },
          DiagnosticVirtualTextWarn = { bg = cp.none },
        }
      end,
    },
  }
end
