local tool = {}

-- Please don't remove which-key.nvim otherwise you need to set timeoutlen=300 at `lua/core/options.lua`
tool["folke/which-key.nvim"] = {
  lazy = true,
  event = "VeryLazy",
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
tool["kylechui/nvim-surround"] = {
  event = "VeryLazy",
  lazy = true,
  opts = {},
}
tool["tpope/vim-fugitive"] = {
  lazy = true,
  event = "CmdlineEnter",
}
tool["nvim-pack/nvim-spectre"] = {
  lazy = false,
  opts = {
    default = { replace = { cmd = "sd" } },
  },
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
