return function()
  require('conform').setup {
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback',
    },
    formatters = {
      clang_format = {
        prepend_args = {
          '-style',
          '{BasedOnStyle: LLVM, IndentWidth: 4}',
        },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      javascript = {},
      typescript = {},
      javascriptreact = {},
      typescriptreact = {},
      css = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      sh = { 'shfmt' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    },
  }
end
