local M = {}

M.setup = function()
  local nvim_lsp = require 'lspconfig'
  local mason_lspconfig = require 'mason-lspconfig'

  require('mason-lspconfig').setup {
    ensure_installed = require('core.settings').lsp_deps,
  }

  vim.diagnostic.config {
    signs = true,
    underline = true,
    virtual_text = { current_line = true, severity = { min = 'INFO', max = 'WARN' } },
    -- virtual_lines = { current_line = true, severity = { min = 'ERROR' } },
    -- severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = true,
      header = '',
    },
    update_in_insert = false,
  }

  local opts = {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  }

  ---A handler to setup all servers defined under `completion/servers/*.lua`
  ---@param lsp_name string
  local function mason_lsp_handler(lsp_name)
    local ok, handler = pcall(require, 'completion.servers.' .. lsp_name)
    if not ok then
      -- Default to use factory config for server(s) that doesn't include a spec
      nvim_lsp[lsp_name].setup(opts)
      return
    elseif type(handler) == 'function' then
      handler(opts)
    elseif type(handler) == 'table' then
      handler.capabilities = require('blink.cmp').get_lsp_capabilities(handler.capabilities)
      nvim_lsp[lsp_name].setup(handler)
    else
      vim.notify(
        string.format(
          "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(handler)
        ),
        vim.log.levels.ERROR,
        { title = 'nvim-lspconfig' }
      )
    end
  end

  mason_lspconfig.setup_handlers { mason_lsp_handler }
end

return M
