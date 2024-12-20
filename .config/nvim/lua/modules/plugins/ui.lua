local ui = {}

ui["goolord/alpha-nvim"] = {
  lazy = true,
  event = "BufWinEnter",
  config = require("ui.alpha"),
}
-- ui["akinsho/bufferline.nvim"] = {
--   lazy = true,
--   event = { "BufReadPost", "BufAdd", "BufNewFile" },
--   config = require("ui.bufferline"),
-- }
ui["catppuccin/nvim"] = {
  lazy = false,
  name = "catppuccin",
  config = require("ui.catppuccin"),
}
ui["Mofiqul/vscode.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  config = require("ui.vscode"),
}
ui["p00f/alabaster.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  init = function()
    vim.g.alabaster_dim_comments = true
  end,
}
ui["marko-cerovac/material.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  config = require("ui.material"),
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
ui["lukas-reineke/indent-blankline.nvim"] = {
  main = "ibl",
  config = function()
    require("ibl").setup()
  end,
}

return ui
