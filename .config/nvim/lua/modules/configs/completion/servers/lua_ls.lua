-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/lua_ls.lua
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'different-requires', 'undefined-field' },
      },
      hint = { enable = false, setType = true },
      format = { enable = false },
      telemetry = { enable = false },
      -- Do not override treesitter lua highlighting with lua_ls's highlighting
      semantic = { enable = false },
    },
  },
}
