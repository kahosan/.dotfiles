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
completion["jose-elias-alvarez/null-ls.nvim"] = {
  lazy = false,
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
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = require("completion.luasnip"),
    },
    { "lukas-reineke/cmp-under-comparator" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "andersevenrud/cmp-tmux" },
    { "hrsh7th/cmp-path" },
    { "f3fora/cmp-spell" },
    { "hrsh7th/cmp-buffer" },
    { "kdheepak/cmp-latex-symbols" },
    { "ray-x/cmp-treesitter" },
    {
      "windwp/nvim-autopairs",
      config = require("completion.autopairs"),
    },
  },
}
completion["zbirenbaum/copilot.lua"] = {
  lazy = true,
  cmd = "Copilot",
  event = "InsertEnter",
  config = require("completion.copilot"),
  -- dependencies = {
  --   {
  --     "zbirenbaum/copilot-cmp",
  --     config = require("completion.copilot-cmp"),
  --   },
  -- },
}

return completion
