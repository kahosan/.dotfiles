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
  opts = require 'tool.snacks',
}
tool['m-demare/attempt.nvim'] = {
  opts = {},
}
tool['ej-shafran/compile-mode.nvim'] = {
  event = 'VeryLazy',
  cmd = { 'Compile', 'Recompile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = require 'tool.compile-mode',
}

return tool
