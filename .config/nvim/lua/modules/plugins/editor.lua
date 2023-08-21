local editor = {}

editor["LunarVim/bigfile.nvim"] = {
  lazy = false,
  config = require("editor.bigfile"),
  cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = {
  lazy = true,
  event = "BufReadPost",
}
editor["numToStr/Comment.nvim"] = {
  lazy = true,
  event = { "BufNewFile", "BufReadPre" },
  config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
  lazy = true,
  cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["romainl/vim-cool"] = {
  lazy = true,
  event = { "CursorMoved", "InsertEnter" },
}
editor["m4xshen/autoclose.nvim"] = {
  lazy = true,
  event = "InsertEnter",
  config = require("editor.autoclose"),
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
  lazy = true,
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.api.nvim_command("TSUpdate")
    end
  end,
  event = "BufReadPre",
  config = require("editor.treesitter"),
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = require("editor.ts-context"),
    },
    {
      "windwp/nvim-ts-autotag",
      config = require("editor.autotag"),
    },
    {
      "NvChad/nvim-colorizer.lua",
      config = require("editor.colorizer"),
    },
  },
}

return editor
