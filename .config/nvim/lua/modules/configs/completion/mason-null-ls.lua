return function()
  require("mason-null-ls").setup({
    automatic_installation = true,
    automatic_setup = false,
    ensure_installed = { "stylua", "eslint_d" }
  })
end