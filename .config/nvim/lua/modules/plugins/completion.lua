local completion = {}

completion['mason-org/mason-lspconfig.nvim'] = {
  config = require 'completion.lsp',
  dependencies = {
    { 'mason-org/mason.nvim' },
    { 'neovim/nvim-lspconfig' },
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
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = require 'completion.conform',
}
-- completion['mfussenegger/nvim-lint'] = {
--   event = 'VeryLazy',
--   config = require 'completion.nvim-lint',
-- }
completion['saghen/blink.cmp'] = {
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '1.*',
  dependencies = {
    'jdrupal-dev/css-vars.nvim',
    'mikavilpas/blink-ripgrep.nvim',
    'xzbdmw/colorful-menu.nvim',
  },
  opts = require 'completion.blink-cmp',
  opts_extend = { 'sources.default' },
}
completion['zbirenbaum/copilot.lua'] = {
  cmd = 'Copilot',
  -- event = 'InsertEnter',
  opts = require 'completion.copilot',
}

return completion
