local editor = {}
local conf = require("modules.editor.config")

editor["RRethy/vim-illuminate"] = {
  event = "BufReadPost",
  config = function()
    vim.g.Illuminate_highlightUnderCursor = 0
    vim.g.Illuminate_ftblacklist = {
      "help",
      "dashboard",
      "alpha",
      "packer",
      "norg",
      "DoomInfo",
      "NvimTree",
      "Outline",
      "toggleterm",
    }
  end,
}
editor["terrortylor/nvim-comment"] = {
  opt = false,
  config = function()
    require("nvim_comment").setup({
      hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
      end,
    })
  end,
}
editor["nvim-treesitter/nvim-treesitter"] = {
  opt = true,
  run = ":TSUpdate",
  event = "BufReadPost",
  config = conf.nvim_treesitter,
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
  opt = true,
  after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
  opt = true,
  after = "nvim-treesitter",
  config = conf.autotag,
}
editor["romainl/vim-cool"] = {
  opt = true,
  event = { "CursorMoved", "InsertEnter" },
}
editor["norcalli/nvim-colorizer.lua"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.nvim_colorizer,
}
editor["jdhao/better-escape.vim"] = { opt = true, event = "InsertEnter" }
editor["famiu/bufdelete.nvim"] = {
  opt = true,
  cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}
editor["abecodes/tabout.nvim"] = {
  opt = true,
  event = "InsertEnter",
  wants = "nvim-treesitter",
  after = "nvim-cmp",
  config = conf.tabout,
}
editor["akinsho/toggleterm.nvim"] = {
  opt = true,
  event = "BufReadPost",
  tag = "v1.*",
  config = conf.toggleterm,
}
editor["numtostr/FTerm.nvim"] = {
  -- opt = true,
  -- event = "BufReadPost"
  opt = false,
}

return editor
