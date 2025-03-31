local completion = {}

completion["neovim/nvim-lspconfig"] = {
  lazy = true,
  event = { "InsertEnter" },
  config = require("completion.lsp"),
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
}
completion["nvimtools/none-ls.nvim"] = {
  lazy = true,
  event = { "InsertEnter" },
  config = require("completion.null-ls"),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
}
completion["hrsh7th/nvim-cmp"] = {
  lazy = true,
  event = "InsertEnter",
  config = require("completion.cmp"),
  dependencies = {
    { "lukas-reineke/cmp-under-comparator" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "andersevenrud/cmp-tmux" },
    { "hrsh7th/cmp-path" },
    { "f3fora/cmp-spell" },
    { "hrsh7th/cmp-buffer" },
    { "ray-x/cmp-treesitter", commit = "c8e3a74" },
  },
}
completion["zbirenbaum/copilot.lua"] = {
  lazy = true,
  cmd = "Copilot",
  event = "InsertEnter",
  config = require("completion.copilot"),
}

return completion
