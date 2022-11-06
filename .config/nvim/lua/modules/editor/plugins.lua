local editor = {}
local conf = require("modules.editor.config")

editor["RRethy/vim-illuminate"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.illuminate,
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
editor["NvChad/nvim-colorizer.lua"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.nvim_colorizer,
}
editor["max397574/better-escape.nvim"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.better_escape,
}
editor["famiu/bufdelete.nvim"] = {
  opt = true,
  cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}
editor["akinsho/toggleterm.nvim"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.toggleterm,
}
editor["numtostr/FTerm.nvim"] = {
  -- opt = true,
  -- event = "BufReadPost"
  opt = false,
}
editor["windwp/nvim-ts-autotag"] = {
  opt = true,
  event = "BufReadPost",
}

return editor
