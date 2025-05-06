local completion = {}

completion['neovim/nvim-lspconfig'] = {
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  config = require 'completion.lsp',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'b0o/schemastore.nvim' },
  },
}
completion['Chaitanyabsprip/fastaction.nvim'] = {
  event = 'LspAttach',
  opts = {
    popup = { border = 'rounded', title = false },
  },
}
completion['dnlhc/glance.nvim'] = {
  cmd = 'Glance',
  config = require 'completion.glance',
}
completion['stevearc/conform.nvim'] = {
  event = 'LspAttach',
  cmd = { 'ConformInfo' },
  config = require 'completion.conform',
}
completion['saghen/blink.cmp'] = {
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '1.*',
  dependencies = {
    'fang2hou/blink-copilot',
    'jdrupal-dev/css-vars.nvim',
    'mikavilpas/blink-ripgrep.nvim',
    'xzbdmw/colorful-menu.nvim',
  },
  opts = require 'completion.blink-cmp',
  opts_extend = { 'sources.default' },
}
completion['zbirenbaum/copilot.lua'] = {
  cmd = 'Copilot',
  -- event = "InsertEnter",
  config = require 'completion.copilot',
}
completion['Exafunction/windsurf.nvim'] = {
  config = require 'completion.windsurf',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}

return completion
