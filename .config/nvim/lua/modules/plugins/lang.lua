local lang = {}

lang['ray-x/go.nvim'] = {
  ft = { 'go', 'gomod', 'gosum' },
  -- manually install
  -- build = ':GoInstallBinaries',
  config = require 'lang.go',
}
lang['mrcjkb/rustaceanvim'] = {
  ft = 'rust',
  init = require 'lang.rust',
  dependencies = { 'nvim-lua/plenary.nvim' },
}
lang['saecki/crates.nvim'] = {
  event = 'BufRead Cargo.toml',
  ft = 'toml',
  opts = {},
  dependencies = { 'nvim-lua/plenary.nvim' },
}

return lang
