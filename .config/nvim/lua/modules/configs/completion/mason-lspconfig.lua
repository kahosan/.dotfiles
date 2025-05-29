local M = {}

M.setup = function()
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = require('core.settings').lsp_deps,
  }

  vim.diagnostic.config {
    -- virtual_text = { prefix = '', current_line = true },
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  }

  -- some server use manual enable
  vim.lsp.enable { 'gopls' }

  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })
end

return M
