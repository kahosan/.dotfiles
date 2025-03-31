local lang = {}

lang["ray-x/go.nvim"] = {
  ft = { "go", "gomod", "gosum" },
  build = ":GoInstallBinaries",
  config = require("lang.go"),
  dependencies = { "ray-x/guihua.lua" },
}
lang["pmizio/typescript-tools.nvim"] = {
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  config = require("lang.typescript"),
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}
lang["mrcjkb/rustaceanvim"] = {
  ft = "rust",
  version = "*",
  init = require("lang.rust"),
  dependencies = { "nvim-lua/plenary.nvim" },
}
lang["saecki/crates.nvim"] = {
  event = "BufRead Cargo.toml",
  ft = "toml",
  opts = {
    completion = {
      cmp = {
        enabled = true,
      },
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
}

return lang
