local completion = {}

completion['neovim/nvim-lspconfig'] = {
  event = { 'CursorHold', 'CursorHoldI' },
  config = require 'completion.lsp',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'b0o/schemastore.nvim' },
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

return completion
