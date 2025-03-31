return function()
  -- local eslint_format = function()
  --   if vim.fn.exists("EslintFixAll") then
  --     vim.cmd("EslintFixAll")
  --   end
  --   return {}
  -- end

  require("conform").setup({
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    default_format_opts = {
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
    },
  })
end
