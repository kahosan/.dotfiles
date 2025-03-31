local tool = {}

tool["folke/which-key.nvim"] = {
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
  config = require("tool.which-key"),
}
tool["nvim-neo-tree/neo-tree.nvim"] = {
  lazy = true,
  cmd = {
    "Neotree",
  },
  config = require("tool.neo-tree"),
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
tool["folke/trouble.nvim"] = {
  lazy = true,
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
  config = require("tool.trouble"),
}
tool["gelguy/wilder.nvim"] = {
  lazy = true,
  event = "CmdlineEnter",
  config = require("tool.wilder"),
  dependencies = { "romgrk/fzy-lua-native" },
}
tool["kylechui/nvim-surround"] = {
  lazy = true,
  event = "VeryLazy",
  opts = {},
}
tool["tpope/vim-fugitive"] = {
  lazy = true,
  cmd = { "Git", "G" },
}
tool["nvim-pack/nvim-spectre"] = {
  lazy = true,
  opts = {
    default = { replace = { cmd = "sd" } },
  },
}
tool["kawre/neotab.nvim"] = {
  lazy = true,
  event = "InsertEnter",
  opts = {},
}
tool["folke/noice.nvim"] = {
  lazy = true,
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = require("tool.noice"),
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
  lazy = true,
  cmd = "Telescope",
  config = require("tool.telescope"),
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "jvgrootveld/telescope-zoxide" },
    { "debugloop/telescope-undo.nvim" },
    { "nvim-telescope/telescope-frecency.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "ahmedkhalf/project.nvim",
      event = { "CursorHold", "CursorHoldI" },
      config = require("tool.project"),
    },
  },
}

return tool
