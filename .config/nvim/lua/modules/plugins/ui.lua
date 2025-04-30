local ui = {}

ui['goolord/alpha-nvim'] = {
  event = 'BufWinEnter',
  config = require 'ui.alpha',
}
ui['catppuccin/nvim'] = {
  name = 'catppuccin',
  config = require 'ui.catppuccin',
}
ui['lewis6991/gitsigns.nvim'] = {
  config = require 'ui.gitsigns',
}
ui['nvim-lualine/lualine.nvim'] = {
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  config = require 'ui.lualine',
}
ui['jake-stewart/auto-cmdheight.nvim'] = {
  event = 'VeryLazy',
  opts = {},
}
ui['j-hui/fidget.nvim'] = {
  opts = {
    notification = { window = { winblend = 0 } },
  },
}
ui['rachartier/tiny-inline-diagnostic.nvim'] = {
  event = 'VeryLazy',
  priority = 1000,
  opts = require 'ui.tiny-inline-diagnostic',
}
ui['nvim-tree/nvim-web-devicons'] = {
  event = 'VeryLazy',
  opts = {},
}

return ui
