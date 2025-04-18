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
ui['Jint-lzxy/nvim'] = {
  branch = 'refactor/syntax-highlighting',
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
ui['echasnovski/mini.indentscope'] = {
  config = function()
    local mini_is = require 'mini.indentscope'
    mini_is.setup {
      symbol = '│',
      draw = { delay = 0, animation = mini_is.gen_animation.none() },
    }
  end,
}
ui['lukas-reineke/indent-blankline.nvim'] = {
  main = 'ibl',
  opts = {
    indent = {
      highlight = { 'WhiteSpace' },
      char = '┊',
    },
    scope = { enabled = false },
  },
}
return ui
