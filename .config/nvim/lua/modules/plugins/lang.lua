local lang = {}

lang["fatih/vim-go"] = {
  lazy = true,
  ft = "go",
  build = ":GoInstallBinaries",
  config = require("lang.vim-go"),
}
lang["simrat39/rust-tools.nvim"] = {
  lazy = true,
  ft = "rust",
  config = require("lang.rust-tools"),
  dependencies = { "nvim-lua/plenary.nvim" },
}

return lang
