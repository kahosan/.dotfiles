local completion = {}

completion["neovim/nvim-lspconfig"] = {
  lazy = true,
  event = { "InsertEnter" },
  config = require("completion.lsp"),
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
      "pmizio/typescript-tools.nvim",
      config = require("completion.typescript-tools"),
      dependencies = {
        { "nvim-lua/plenary.nvim" },
      },
    },
  },
}
completion["stevearc/conform.nvim"] = {
  lazy = true,
  event = { "LspAttach" },
  cmd = { "ConformInfo" },
  config = require("completion.conform"),
  dependencies = {
    "zapling/mason-conform.nvim",
  },
}
completion["rachartier/tiny-inline-diagnostic.nvim"] = {
  lazy = true,
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      signs = {
        left = "",
        right = "",
        diag = "■",
        arrow = "",
        up_arrow = "",
        vertical = "  │",
        vertical_end = "  └",
      },
      blend = { factor = 0 },
      hi = {
        background = "None",
      },
      options = {
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
completion["saghen/blink.cmp"] = {
  lazy = true,
  event = { "InsertEnter" },
  version = "1.*",
  dependencies = {
    "fang2hou/blink-copilot",
    "jdrupal-dev/css-vars.nvim",
    "mikavilpas/blink-ripgrep.nvim",
  },
  opts = require("completion.blink-cmp"),
  opts_extend = { "sources.default" },
}
completion["zbirenbaum/copilot.lua"] = {
  lazy = true,
  cmd = "Copilot",
  event = "InsertEnter",
  config = require("completion.copilot"),
}

return completion
