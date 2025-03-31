local editor = {}

editor["pteroctopus/faster.nvim"] = {
  lazy = false,
  cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = {
  lazy = true,
  cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
}
editor["numToStr/Comment.nvim"] = {
  lazy = true,
  event = { "CursorHold", "CursorHoldI" },
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
editor["windwp/nvim-autopairs"] = {
  lazy = true,
  event = "InsertEnter",
  opts = {
    enable_check_bracket_line = false,
  },
  init = function()
    local npairs = require("nvim-autopairs")
    local rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({ rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex("|")) })
  end,
}
editor["tpope/vim-sleuth"] = {
  lazy = true,
  event = { "BufNewFile", "BufReadPost", "BufFilePost" },
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
  lazy = true,
  build = function()
    if vim.fn.has("gui_running") == 1 then
      vim.api.nvim_command([[TSUpdate]])
    end
  end,
  event = "BufReadPre",
  config = require("editor.treesitter"),
  dependencies = {
    { "windwp/nvim-ts-autotag" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = require("editor.ts-context"),
    },
    {
      "NvChad/nvim-colorizer.lua",
      config = require("editor.colorizer"),
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        vim.g.skip_ts_context_commentstring_module = true
        require("ts_context_commentstring").setup({
          -- Whether to update the `commentstring` on the `CursorHold` autocmd
          enable_autocmd = false,
        })
      end,
    },
  },
}

return editor
