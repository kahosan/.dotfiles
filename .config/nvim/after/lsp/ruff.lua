return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      organizeImports = false, -- in favor of Conform (:Format ruff_organize_imports)
      lineLength = 120,
      lint = {
        preview = true,
        -- select = { 'E4', 'E7', 'E9', 'F', 'PTH' },
        select = { 'E', 'W', 'F', 'UP', 'PTH' },
        ignore = {
          'E111', -- indentation-with-invalid-multiple
          'E114', -- indentation-with-invalid-multiple-comment
          'E402', -- module-import-not-at-top-of-file
          'E501', -- line-too-long
          'E702', -- multiple-statements-on-one-line-semicolon
          'E731', -- lambda-assignment
          'F401', -- unused-import  (note: should be handled by pyright as 'hint')
        },
      },
    },
  },
}
