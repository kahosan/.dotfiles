return function()
  local nvim_lsp = require("lspconfig")
  require("completion.mason").setup()
  require("completion.mason-lspconfig").setup()

  local opts = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  }

  -- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
  if vim.fn.executable("dart") == 1 then
    local _opts = require("completion.servers.dartls")
    nvim_lsp.dartls.setup(vim.tbl_deep_extend("keep", _opts, opts))
  end

  pcall(vim.cmd.LspStart) -- Start LSPs
end
