local ui = {}

ui['catppuccin/nvim'] = {
  name = 'catppuccin',
  config = require 'ui.catppuccin',
}
ui['wtfox/jellybeans.nvim'] = {
  opts = require 'ui.jellybeans',
}
ui['lewis6991/gitsigns.nvim'] = {
  config = require 'ui.gitsigns',
}
-- ui['nvim-lualine/lualine.nvim'] = {
--   event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
--   config = require 'ui.lualine',
-- }
ui['rebelot/heirline.nvim'] = {
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('heirline').setup {
      statusline = require 'ui.heirline.statusline',
    }
  end,
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
  event = 'LspAttach',
  opts = require 'ui.tiny-inline-diagnostic',
}
ui['nvim-tree/nvim-web-devicons'] = {
  event = 'VeryLazy',
  opts = {},
}

return ui
