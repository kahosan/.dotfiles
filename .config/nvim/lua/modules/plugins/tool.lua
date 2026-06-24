local tool = {}

tool['folke/which-key.nvim'] = {
  event = { 'CursorHold', 'CursorHoldI' },
  config = require 'tool.which-key',
}
tool['nvim-neo-tree/neo-tree.nvim'] = {
  cmd = { 'Neotree' },
  config = require 'tool.neo-tree',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
tool['santhosh-tekuri/quickfix.nvim'] = {
  event = 'VeryLazy',
  config = function()
    vim.o.quickfixtextfunc = require('quickfix').quickfixtextfunc
  end,
}
tool['stevearc/oil.nvim'] = {
  opts = {
    default_file_explorer = true,
    columns = { 'permissions', 'size', 'mtime' },
    constrain_cursor = 'name',
    view_options = { show_hidden = true },
    keymaps = {
      ['<C-h>'] = 'actions.parent',
      ['<C-l>'] = 'actions.select',
      ['-'] = 'actions.close',
      ['<C-r>'] = 'actions.refresh',
      ['<C-c>'] = '<Esc>',
    },
  },
}
tool['kylechui/nvim-surround'] = {
  event = 'VeryLazy',
  opts = {},
}
tool['tpope/vim-fugitive'] = {
  cmd = { 'Git', 'G' },
}
tool['MagicDuck/grug-far.nvim'] = {
  config = require 'tool.grug-far',
}
tool['kawre/neotab.nvim'] = {
  event = 'InsertEnter',
  opts = {},
}
tool['folke/snacks.nvim'] = {
  priority = 1000,
  opts = require 'tool.snacks',
}
tool['m-demare/attempt.nvim'] = {
  lazy = false,
  opts = {
    list_buffers = true,
  },
}

return tool
