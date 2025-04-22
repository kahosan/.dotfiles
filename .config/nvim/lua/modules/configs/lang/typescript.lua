return function()
  require('typescript-tools').setup {
    tsserver_file_preferences = {
      updateImportsOnFileMove = { enabled = 'always' },
    },
  }
end
