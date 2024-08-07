local completion = {}

completion["neovim/nvim-lspconfig"] = {
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = require("completion.lsp"),
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
}
completion["nvimtools/none-ls.nvim"] = {
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
  config = require("completion.null-ls"),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
}
completion["hrsh7th/nvim-cmp"] = {
  lazy = true,
  event = "InsertEnter",
  config = require("completion.cmp"),
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = require("completion.luasnip"),
    },
    { "lukas-reineke/cmp-under-comparator" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-path" },
    { "f3fora/cmp-spell" },
    { "hrsh7th/cmp-buffer" },
    { "ray-x/cmp-treesitter" },
  },
}
completion["zbirenbaum/copilot.lua"] = {
  lazy = true,
  cmd = "Copilot",
  event = "InsertEnter",
  config = require("completion.copilot"),
}

return completion
