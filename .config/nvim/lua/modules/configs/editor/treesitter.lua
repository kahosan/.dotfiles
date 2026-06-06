return function()
  vim.api.nvim_set_option_value('indentexpr', "v:lua.require'nvim-treesitter'.indentexpr()", {})

  require('nvim-treesitter').setup {}

  require('nvim-treesitter').install(require('core.settings').treesitter_deps)
end
