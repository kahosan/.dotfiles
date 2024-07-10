return function()
  require("neodim").setup({
    alpha = 0.45,
    blend_color = "#000000",
    hide = { underline = true, virtual_text = true, signs = true },
    priority = 80, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
    disable = {
      "alpha",
      "bigfile",
      "checkhealth",
      "dap-repl",
      "diff",
      "fugitive",
      "fugitiveblame",
      "git",
      "gitcommit",
      "help",
      "log",
      "notify",
      "NvimTree",
      "Outline",
      "qf",
      "TelescopePrompt",
      "text",
      "toggleterm",
      "undotree",
      "vimwiki",
    },
  })
end
