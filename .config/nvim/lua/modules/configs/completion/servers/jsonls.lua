-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/jsonls.lua
return {
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
