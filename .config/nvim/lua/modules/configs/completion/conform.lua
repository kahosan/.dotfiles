return function()
  require("mason-conform").setup({
    ignore_install = { "prettier", "prettierd" },
  })

  require("conform").setup({
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      clang_format = {
        prepend_args = {
          "-style",
          "{BasedOnStyle: LLVM, IndentWidth: 4}",
        },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      css = { "prettierd", "prettier", stop_after_first = true },
      json = { "eslint", "prettierd", "prettier", stop_after_first = true },
      yaml = { "eslint", "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shellcheck" },
      python = { "ruff" },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  })
end
