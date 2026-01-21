local o = vim.opt

o.number = false
o.relativenumber = false
o.statuscolumn = ''
o.signcolumn = 'no'
o.cursorline = true
o.clipboard = 'unnamedplus'

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', 'q', '<cmd>qa!<cr>', opts)
map('n', '<Esc>', '<cmd>qa!<cr>', opts)

vim.cmd [[
  highlight Normal guifg=#d6d6d6 guibg=#181819
  highlight SignColumn guifg=#45475b
  highlight LineNr guibg=#000000
  highlight CursorLineNr guibg=#000000
  highlight EndOfBuffer guibg=#181819 guifg=#d6d6d6
  highlight CursorLine guibg=#282935
]]

vim.api.nvim_create_autocmd('StdinReadPost', {
  callback = function()
    vim.cmd [[silent! %s/\s\+$//e]]

    vim.bo.modified = false
  end,
})
