local lang = {}

lang['ray-x/go.nvim'] = {
  ft = { 'go', 'gomod', 'gosum' },
  -- manually install
  -- build = ':GoInstallBinaries',
  config = require 'lang.go',
  dependencies = { 'ray-x/guihua.lua' },
}
lang['razak17/tailwind-fold.nvim'] = {
  opts = {},
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
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
