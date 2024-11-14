return function()
  local nvim_lsp = require("lspconfig")
  require("completion.mason").setup()
  require("completion.mason-lspconfig").setup()

  local opts = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
  -- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
  if vim.fn.executable("dart") == 1 then
    opts = require("completion.servers.dartls")
    nvim_lsp.dartls.setup(opts)
  end

  pcall(vim.cmd.LspStart) -- Start LSPs
end
