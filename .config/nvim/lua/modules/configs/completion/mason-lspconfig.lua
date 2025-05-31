local M = {}

M.setup = function()
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = require('core.settings').lsp_deps,
  }
end

return M
