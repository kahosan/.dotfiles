local ui = {}

ui['goolord/alpha-nvim'] = {
  event = 'BufWinEnter',
  config = require 'ui.alpha',
}
ui['p00f/alabaster.nvim'] = {
  event = 'BufReadPost',
  init = function()
    vim.g.alabaster_dim_comments = true
  end,
}
ui['catppuccin/nvim'] = {
  name = 'catppuccin',
  config = require 'ui.catppuccin',
}
ui['lewis6991/gitsigns.nvim'] = {
  event = { 'CursorHold', 'CursorHoldI' },
  config = require 'ui.gitsigns',
}
ui['nvim-lualine/lualine.nvim'] = {
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  config = require 'ui.lualine',
}
ui['lukas-reineke/indent-blankline.nvim'] = {
  main = 'ibl',
  opts = require 'ui.indent-blankline',
}
ui['jake-stewart/auto-cmdheight.nvim'] = {
  opts = {
    max_lines = 5,
    duration = 2,
    remove_on_key = true,
    clear_always = false,
  },
}

return ui
