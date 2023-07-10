return function()
  require("neodim").setup({
    alpha = 0.45,
    blend_color = "#000000",
    hide = { underline = false, virtual_text = true, signs = false },
    priority = 80, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
    disable = {}, -- table of filetypes to disable neodim
  })
end
