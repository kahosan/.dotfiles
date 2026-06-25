return {
  settings = {
    yaml = {
      format = {
        singleQuote = true,
      },
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
