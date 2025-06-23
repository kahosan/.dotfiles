return function()
  local formatters_by_ft = {
    -- 配置此项后，有 LSP 的格式化功能但不在表里的，都不会生效了
    _ = { 'trim_whitespace' },
    lua = { 'stylua' },
    go = { 'goimports', 'gofmt' },
    rust = { 'rustfmt' },
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
    format_on_save = {
      timeout_ms = 500,
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
    formatters_by_ft = formatters_by_ft,
  }
end
