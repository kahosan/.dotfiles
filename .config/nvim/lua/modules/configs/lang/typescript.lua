return function()
  require('typescript-tools').setup {
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNamesSuppressWhenArgumentMatchesName = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  }
end
