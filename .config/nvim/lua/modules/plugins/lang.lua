local lang = {}

lang["fatih/vim-go"] = {
  lazy = true,
  ft = "go",
  build = ":GoInstallBinaries",
  config = require("lang.vim-go"),
}
lang["mrcjkb/rustaceanvim"] = {
  lazy = false,
  ft = "rust",
  version = "^5",
  config = require("lang.rust"),
  dependencies = { "nvim-lua/plenary.nvim" },
}

return lang
