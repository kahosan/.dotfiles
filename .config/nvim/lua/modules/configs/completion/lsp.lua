return function()
  require('completion.mason').setup()
  require('completion.mason-lspconfig').setup()

  pcall(vim.cmd.LspStart) -- Start LSPs
end
