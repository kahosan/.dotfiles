local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_callback = bind.map_callback
local map_cu = bind.map_cu

local mappings = {
  layz = {
    -- Package manager: lazy.nvim
    ['n|<leader>ph'] = map_cr('Lazy'):with_silent():with_noremap():with_nowait():with_desc 'package: Show',
    ['n|<leader>ps'] = map_cr('Lazy sync'):with_silent():with_noremap():with_nowait():with_desc 'package: Sync',
    ['n|<leader>pu'] = map_cr('Lazy update'):with_silent():with_noremap():with_nowait():with_desc 'package: Update',
    ['n|<leader>pi'] = map_cr('Lazy install'):with_silent():with_noremap():with_nowait():with_desc 'package: Install',
    ['n|<leader>pl'] = map_cr('Lazy log'):with_silent():with_noremap():with_nowait():with_desc 'package: Log',
    ['n|<leader>pc'] = map_cr('Lazy check'):with_silent():with_noremap():with_nowait():with_desc 'package: Check',
    ['n|<leader>pd'] = map_cr('Lazy debug'):with_silent():with_noremap():with_nowait():with_desc 'package: Debug',
    ['n|<leader>pp'] = map_cr('Lazy profile'):with_silent():with_noremap():with_nowait():with_desc 'package: Profile',
    ['n|<leader>pr'] = map_cr('Lazy restore'):with_silent():with_noremap():with_nowait():with_desc 'package: Restore',
    ['n|<leader>px'] = map_cr('Lazy clean'):with_silent():with_noremap():with_nowait():with_desc 'package: Clean',
  },
  lsp = {
    ['n|<leader>li'] = map_cr('LspInfo'):with_noremap():with_silent():with_nowait():with_desc 'lsp: Info',
    ['n|<leader>lr'] = map_cr('LspRestart'):with_noremap():with_silent():with_nowait():with_desc 'lsp: Restart',
    ['n|<leader>k'] = map_callback(function()
        vim.diagnostic.open_float()
      end)
      :with_noremap()
      :with_silent()
      :with_nowait()
      :with_desc 'lsp diagnostic info',
    ['n|gD'] = map_cr('Glance definitions'):with_silent():with_noremap():with_nowait():with_desc 'lsp: definitions',
    ['n|gl'] = map_cr('Glance references'):with_silent():with_noremap():with_nowait():with_desc 'lsp: references',
    ['n|gi'] = map_cr('Glance implementations')
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc 'lsp: implementations',
    ['n|K'] = map_callback(function()
        vim.lsp.buf.hover { border = 'single', max_height = 25, max_width = 70 }
      end)
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc 'lsp: hover',
    ['n|gd'] = map_cr('lua vim.lsp.buf.definition()')
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc 'lsp: definitions',
    ['n|gr'] = map_cr('lua vim.lsp.buf.rename()'):with_silent():with_noremap():with_nowait():with_desc 'lsp: rename',
    ['n|ga'] = map_cr('lua vim.lsp.buf.code_action()')
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc 'lsp: code action',
    ['n|gs'] = map_cr('lua vim.lsp.buf.signature_help()')
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc 'lsp: signature_help',
  },
  git = {
    ['n|<leader>G'] = map_cu('Git'):with_noremap():with_silent():with_desc 'git: Open git-fugitive',
    ['n|<leader>D'] = map_cr('DiffviewOpen'):with_silent():with_noremap():with_desc 'git: Show diff',
    ['n|<leader><leader>D'] = map_cr('DiffviewClose'):with_silent():with_noremap():with_desc 'git: Close diff',
  },
}

bind.nvim_load_mapping(mappings.layz)
bind.nvim_load_mapping(mappings.lsp)
bind.nvim_load_mapping(mappings.git)

require 'keymap.core'
require 'keymap.plug'
