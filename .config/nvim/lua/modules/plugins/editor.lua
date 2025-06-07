local editor = {}

editor['ojroques/nvim-bufdel'] = {
  cmd = { 'BufDel', 'BufDelAll', 'BufDelOthers' },
}
editor['tpope/vim-sleuth'] = {
  event = { 'BufNewFile', 'BufReadPost', 'BufFilePost' },
}
editor['sindrets/diffview.nvim'] = {
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  opts = require 'editor.diffview',
}
editor['catgoose/nvim-colorizer.lua'] = {
  event = 'BufReadPre',
  opts = {},
}
editor['m4xshen/autoclose.nvim'] = {
  event = 'InsertEnter',
  config = require 'editor.autoclose',
}
editor['nmac427/guess-indent.nvim'] = {
  event = 'InsertEnter',
  opts = require 'editor.guess-indent',
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor['nvim-treesitter/nvim-treesitter'] = {
  build = ':TSUpdate',
  event = 'BufReadPre',
  config = require 'editor.treesitter',
  dependencies = {
    { 'windwp/nvim-ts-autotag', config = true },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = require 'editor.ts-context',
    },
  },
}

return editor
