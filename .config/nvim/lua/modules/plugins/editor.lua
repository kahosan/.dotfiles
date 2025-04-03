local editor = {}

editor['pteroctopus/faster.nvim'] = {
  cond = require('core.settings').load_big_files_faster,
}
editor['ojroques/nvim-bufdel'] = {
  cmd = { 'BufDel', 'BufDelAll', 'BufDelOthers' },
}
editor['sindrets/diffview.nvim'] = {
  cmd = { 'DiffviewOpen', 'DiffviewClose' },
}
editor['romainl/vim-cool'] = {
  event = { 'CursorMoved', 'InsertEnter' },
}
editor['tpope/vim-sleuth'] = {
  event = { 'BufNewFile', 'BufReadPost', 'BufFilePost' },
}
editor['catgoose/nvim-colorizer.lua'] = {
  event = 'BufReadPre',
  opts = {},
}
editor['windwp/nvim-autopairs'] = {
  event = 'InsertEnter',
  opts = {
    enable_check_bracket_line = false,
  },
  init = function()
    local npairs = require 'nvim-autopairs'
    local rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    npairs.add_rules { rule('|', '|', { 'rust', 'go', 'lua' }):with_move(cond.after_regex '|') }
  end,
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor['nvim-treesitter/nvim-treesitter'] = {
  build = ':TSUpdate',
  event = 'BufReadPre',
  config = require 'editor.treesitter',
  dependencies = {
    { 'windwp/nvim-ts-autotag' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = require 'editor.ts-context',
    },
  },
}

return editor
