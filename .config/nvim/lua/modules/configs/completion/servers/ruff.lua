return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    -- https://github.com/astral-sh/ruff-lsp#settings
    -- https://github.com/astral-sh/ruff-lsp/blob/main/ruff_lsp/server.py
    -- Note: use pyproject.toml to configure ruff per project.
    settings = {
      fixAll = true,
      organizeImports = false, -- in favor of Conform (:Format ruff_organize_imports)
      -- extra CLI arguments
      -- https://docs.astral.sh/ruff/configuration/#command-line-interface
      -- https://docs.astral.sh/ruff/rules/
      args = {
        '--preview', -- Use experimental features
        '--ignore',
        table.concat({
          'E111', -- indentation-with-invalid-multiple
          'E114', -- indentation-with-invalid-multiple-comment
          'E402', -- module-import-not-at-top-of-file
          'E501', -- line-too-long
          'E702', -- multiple-statements-on-one-line-semicolon
          'E731', -- lambda-assignment
          'F401', -- unused-import  (note: should be handled by pyright as 'hint')
        }, ','),
      },
    },
  },
}
