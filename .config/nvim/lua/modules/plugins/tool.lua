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
tool['folke/trouble.nvim'] = {
  cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
  config = require 'tool.trouble',
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
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    quickfile = {
      exclude = { 'latex' },
    },
  },
}
tool['rmagatti/auto-session'] = {
  lazy = false,
  cmd = { 'SessionRestore', 'SessionSearch', 'SessionSave' },
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    log_level = 'error',
    suppressed_dirs = { '~/', '~/Downloads', '/' },
    bypass_save_filetypes = { 'help', 'alpha', 'telescope', 'trouble' },
  },
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = require 'tool.telescope',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'jvgrootveld/telescope-zoxide' },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
}

return tool
