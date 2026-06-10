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
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
}
editor['autoclose'] = {
  dev = true,
  event = 'InsertEnter',
  config = require 'editor.autoclose',
}
editor['nmac427/guess-indent.nvim'] = {
  event = 'InsertEnter',
  opts = require 'editor.guess-indent',
}
editor['jake-stewart/multicursor.nvim'] = {
  branch = '1.0',
  config = require 'editor.multicursor',
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor['nvim-treesitter/nvim-treesitter'] = {
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
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
