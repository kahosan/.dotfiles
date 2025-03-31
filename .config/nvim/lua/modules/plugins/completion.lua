local completion = {}

completion["neovim/nvim-lspconfig"] = {
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
  config = require("completion.lsp"),
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "dnlhc/glance.nvim", cmd = "Glance" },
  },
}
completion["stevearc/conform.nvim"] = {
  lazy = true,
  event = "LspAttach",
  cmd = { "ConformInfo" },
  config = require("completion.conform"),
}
completion["saghen/blink.cmp"] = {
  version = "1.*",
  dependencies = {
    "fang2hou/blink-copilot",
    "jdrupal-dev/css-vars.nvim",
    "mikavilpas/blink-ripgrep.nvim",
    "xzbdmw/colorful-menu.nvim",
  },
  opts = require("completion.blink-cmp"),
  opts_extend = { "sources.default" },
}
completion["zbirenbaum/copilot.lua"] = {
  lazy = true,
  cmd = "Copilot",
  -- event = "InsertEnter",
  config = require("completion.copilot"),
}

return completion
