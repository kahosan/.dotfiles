local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = {
  opt = false,
}
ui["catppuccin/nvim"] = {
  commit = "8a67df6",
  opt = false,
  as = "catppuccin",
  config = conf.catppuccin,
}
-- ui["arkav/lualine-lsp-progress"] = {
--   opt = true, after = "nvim-gps"
-- }
ui["j-hui/fidget.nvim"] = {
  opt = true,
  event = "BufReadPost",
  config = function()
    require("fidget").setup({})
  end,
}
ui["hoob3rt/lualine.nvim"] = {
  opt = true,
  -- after = "lualine-lsp-progress",
  after = "nvim-gps",
  config = conf.lualine,
}
ui["SmiteshP/nvim-gps"] = {
  opt = true,
  after = "nvim-treesitter",
  config = conf.nvim_gps,
}
ui["kyazdani42/nvim-tree.lua"] = {
  opt = true,
  cmd = { "NvimTreeToggle" },
  config = conf.nvim_tree,
}
ui["lewis6991/gitsigns.nvim"] = {
  opt = true,
  event = { "BufReadPost", "BufNewFile" },
  config = conf.gitsigns,
  requires = { "nvim-lua/plenary.nvim", opt = true },
}
ui["akinsho/bufferline.nvim"] = {
  opt = true,
  tag = "*",
  event = "BufReadPost",
  config = conf.nvim_bufferline,
}
ui["goolord/alpha-nvim"] = {
  opt = true,
  event = "BufWinEnter",
  config = conf.alpha,
}
ui["lukas-reineke/indent-blankline.nvim"] = {
  opt = true,
  event = "BufReadPost",
  config = conf.indent_blankline,
}

return ui
