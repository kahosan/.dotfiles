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
completion["rmagatti/goto-preview"] = {
  lazy = true,
  config = function()
    require("goto-preview").setup({
      post_open_hook = function(_, win)
        -- Close the current preview window with <Esc>
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = true })
      end,
    })
  end,
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
