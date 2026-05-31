return {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand '$VIMRUNTIME/lua',
          -- vim.fn.expand '$XDG_CONFIG_HOME' .. '/nvim/lua',
        },
      },
    },
  },
}
