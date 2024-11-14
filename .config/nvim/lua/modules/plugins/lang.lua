local lang = {}

lang["ray-x/go.nvim"] = {
  lazy = true,
  ft = { "go", "gomod", "gosum" },
  build = ":GoInstallBinaries",
  config = require("lang.go"),
  dependencies = { "ray-x/guihua.lua" },
}
lang["mrcjkb/rustaceanvim"] = {
  lazy = true,
  ft = "rust",
  version = "*",
  init = require("lang.rust"),
  dependencies = { "nvim-lua/plenary.nvim" },
}

return lang
