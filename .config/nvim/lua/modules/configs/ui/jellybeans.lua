local transparent_background = require('core.settings').transparent_background

return {
  transparent = transparent_background,
  italics = true,
  flat_ui = true,
  plugins = {
    all = false,
    auto = true,
  },
  on_highlights = function(hl, c)
    hl.MatchParen = { bg = '#575279', fg = '#faf4ed' }
  end,
  -- on_colors = function(c) end,
}
