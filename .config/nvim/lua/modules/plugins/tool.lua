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
tool['kylechui/nvim-surround'] = {
  event = 'VeryLazy',
  opts = {},
}
tool['tpope/vim-fugitive'] = {
  cmd = { 'Git', 'G' },
}
tool['nvim-pack/nvim-spectre'] = {
  lazy = true,
  opts = {
    default = { replace = { cmd = 'sd' } },
  },
}
tool['kawre/neotab.nvim'] = {
  event = 'InsertEnter',
  opts = {},
}
tool['folke/snacks.nvim'] = {
  opts = require 'tool.snacks',
}

return tool
