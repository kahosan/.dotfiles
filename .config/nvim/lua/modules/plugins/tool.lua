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
tool["gelguy/wilder.nvim"] = {
  lazy = true,
  event = "CmdlineEnter",
  config = require("tool.wilder"),
  dependencies = { "romgrk/fzy-lua-native" },
}
tool["kylechui/nvim-surround"] = {
  event = "VeryLazy",
  lazy = true,
  config = function()
    require("nvim-surround").setup({})
  end,
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
  lazy = true,
  cmd = "Telescope",
  config = require("tool.telescope"),
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },
    { "debugloop/telescope-undo.nvim" },
    {
      "ahmedkhalf/project.nvim",
      event = "BufReadPost",
      config = require("tool.project"),
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = {
        { "kkharji/sqlite.lua" },
      },
    },
    { "jvgrootveld/telescope-zoxide" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
}

return tool
