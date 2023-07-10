return function()
  local settings = require("core.settings")

  require("rose-pine").setup({
    disable_background = settings.transparent_background,
    disable_float_background = settings.transparent_background,
  })
end
