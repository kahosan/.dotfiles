return function()
  local formatters_by_ft = {
    _ = { 'trim_whitespace', lsp_format = 'first' },
    lua = { 'stylua' },
    go = { 'goimports', 'gofmt' },
    sh = { 'shfmt' },
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
  }

  local prettier_ft = { 'css', 'json', 'yaml', 'scss' }
  local clang_ft = { 'c', 'cpp' }

  for _, ft in ipairs(prettier_ft) do
    formatters_by_ft[ft] = { 'prettierd', 'prettier', stop_after_first = true }
  end

  for _, ft in ipairs(clang_ft) do
    formatters_by_ft[ft] = { 'clang-format' }
  end

  require('conform').setup {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = {
      timeout_ms = 500,
    },
    formatters = {
      clang_format = {
        prepend_args = {
          '-style',
          '{BasedOnStyle: LLVM, IndentWidth: 4}',
        },
      },
    },
    formatters_by_ft = formatters_by_ft,
  }
end
