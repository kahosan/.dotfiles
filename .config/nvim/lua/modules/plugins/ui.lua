local ui = {}

ui["goolord/alpha-nvim"] = {
  lazy = true,
  event = "BufWinEnter",
  config = require("ui.alpha"),
}
ui["akinsho/bufferline.nvim"] = {
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = require("ui.bufferline"),
}
-- ui["catppuccin/nvim"] = {
--   lazy = false,
--   name = "catppuccin",
--   config = require("ui.catppuccin"),
-- }
ui["rose-pine/neovim"] = {
  lazy = true,
  name = "rose-pine",
  config = require("ui.rose-pine"),
}
ui["j-hui/fidget.nvim"] = {
  lazy = true,
  branch = "legacy",
  event = "LspAttach",
  config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = require("ui.gitsigns"),
}
ui["nvim-lualine/lualine.nvim"] = {
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = require("ui.lualine"),
}
ui["zbirenbaum/neodim"] = {
  lazy = false,
  branch = "v2",
  event = "LspAttach",
  config = require("ui.neodim"),
}
ui["lukas-reineke/indent-blankline.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  config = require("ui.indent-blankline"),
}
-- ui["edluffy/specs.nvim"] = {
-- 	lazy = true,
-- 	event = "CursorMoved",
-- 	config = require("ui.specs"),
-- }

return ui
