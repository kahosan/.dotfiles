local editor = {}

editor['pteroctopus/faster.nvim'] = {
  cond = require('core.settings').load_big_files_faster,
}
editor['ojroques/nvim-bufdel'] = {
  cmd = { 'BufDel', 'BufDelAll', 'BufDelOthers' },
}
editor['sindrets/diffview.nvim'] = {
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  opts = {
    hooks = {
      diff_buf_win_enter = function(_, winid, _)
        -- Turn off cursor line for diffview windows because of bg conflict
        -- https://github.com/neovim/neovim/issues/9800
        vim.wo[winid].culopt = 'number'
      end,
    },
  },
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
editor['m4xshen/autoclose.nvim'] = {
  event = 'InsertEnter',
  config = require 'editor.autoclose',
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
