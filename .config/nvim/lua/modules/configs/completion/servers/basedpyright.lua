return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        -- https://github.com/DetachHead/basedpyright/issues/203
        typeCheckingMode = 'basic',
      },
    },
  },
}
