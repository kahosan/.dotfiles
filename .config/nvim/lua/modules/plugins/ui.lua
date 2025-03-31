local ui = {}

ui["goolord/alpha-nvim"] = {
  lazy = true,
  event = "BufWinEnter",
  config = require("ui.alpha"),
}
ui["p00f/alabaster.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  init = function()
    vim.g.alabaster_dim_comments = true
  end,
}
ui["marko-cerovac/material.nvim"] = {
  lazy = true,
  event = "BufReadPost",
  config = require("ui.material"),
}
ui["j-hui/fidget.nvim"] = {
  lazy = true,
  event = "LspAttach",
  config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
  config = require("ui.gitsigns"),
}
ui["nvim-lualine/lualine.nvim"] = {
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = require("ui.lualine"),
}
ui["echasnovski/mini.indentscope"] = {
  version = "*",
  opts = {
    -- symbol = "│",
    symbol = "|",
  },
}
ui["lukas-reineke/indent-blankline.nvim"] = {
  main = "ibl",
  opts = {
    indent = {
      highlight = {
        "WhiteSpace",
      },
      char = "┊",
    },
    scope = {
      enabled = false,
    },
  },
}
return ui
