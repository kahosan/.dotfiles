local transparent_background = require('core.settings').transparent_background

return {
  transparent = transparent_background,
  italics = true,
  flat_ui = true,
  plugins = {
    all = false,
    auto = true,
  },
  on_highlights = function(highlights, colors) end,
  on_colors = function(colors) end,
}
