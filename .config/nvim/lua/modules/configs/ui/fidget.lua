return function()
  require("fidget").setup({
    notification = {
      override_vim_notify = true,
      window = {
        winblend = 0,
        zindex = 75,
      },
    },
  })
end
