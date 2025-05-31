return function()
  require('completion.mason').setup()
  require('completion.mason-lspconfig').setup()

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
