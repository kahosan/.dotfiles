local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local builtins = {
  -- Suckless
  ['n|n'] = map_cmd('nzzzv'):with_noremap():with_desc 'editn: Next search result',
  ['n|N'] = map_cmd('Nzzzv'):with_noremap():with_desc 'editn: Prev search result',
  ['n|J'] = map_cmd('mzJ`z'):with_noremap():with_desc 'editn: Join next line',

  -- Normal mode
  ['n|<C-s>'] = map_cu('write'):with_noremap():with_silent():with_desc 'editn: Save file',
  ['n|<C-q>'] = map_cmd(':q<CR>'):with_desc 'editn: Save file and quit',
  ['n|<C-h>'] = map_cmd('<C-w>h'):with_noremap():with_desc 'window: Focus left',
  ['n|<C-l>'] = map_cmd('<C-w>l'):with_noremap():with_desc 'window: Focus right',
  ['n|<C-j>'] = map_cmd('<C-w>j'):with_noremap():with_desc 'window: Focus down',
  ['n|<C-k>'] = map_cmd('<C-w>k'):with_noremap():with_desc 'window: Focus up',
  ['t|<C-h>'] = map_cmd('<Cmd>wincmd h<CR>'):with_silent():with_noremap():with_desc 'window: Focus left',
  ['t|<C-l>'] = map_cmd('<Cmd>wincmd l<CR>'):with_silent():with_noremap():with_desc 'window: Focus right',
  ['t|<C-j>'] = map_cmd('<Cmd>wincmd j<CR>'):with_silent():with_noremap():with_desc 'window: Focus down',
  ['t|<C-k>'] = map_cmd('<Cmd>wincmd k<CR>'):with_silent():with_noremap():with_desc 'window: Focus up',
  ['n|<A-[>'] = map_cr('vertical resize -5'):with_silent():with_desc 'window: Resize -5 vertically',
  ['n|<A-]>'] = map_cr('vertical resize +5'):with_silent():with_desc 'window: Resize +5 vertically',
  ['n|<A-;>'] = map_cr('resize -2'):with_silent():with_desc 'window: Resize -2 horizontally',
  ["n|<A-'>"] = map_cr('resize +2'):with_silent():with_desc 'window: Resize +2 horizontally',
  ['n|g.'] = map_cmd('/\\V\\C<C-r>"<CR>cgn<C-a><Esc>'):with_silent():with_noremap():with_desc 'editn: Repeat last ciw',

  -- Insert mode
  ['i|<C-c>'] = map_cmd('<Esc>'):with_noremap():with_desc 'remap esc',
  ['i|<C-u>'] = map_cmd('<C-G>u<C-U>'):with_noremap():with_desc 'editi: Delete previous block',
  ['i|<C-b>'] = map_cmd('<Left>'):with_noremap():with_desc 'editi: Move cursor to left',
  ['i|<C-a>'] = map_cmd('<Esc>^i'):with_noremap():with_desc 'editi: Move cursor to line start',
  ['i|<C-s>'] = map_cmd('<Esc>:w<CR>'):with_desc 'editi: Save file',
  ['i|<C-q>'] = map_cmd('<Esc>:wq<CR>'):with_desc 'editi: Save file and quit',
  ['i|<C-n>'] = map_cmd('<Nop>'):with_noremap():with_silent(),
  ['i|<C-p>'] = map_cmd('<Nop>'):with_noremap():with_silent(),
  ['i|<C-l>'] = map_callback(function()
      local node = vim.treesitter.get_node()
      if node ~= nil then
        local row, col = node:end_()
        pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
      end
    end)
    :with_silent()
    :with_desc 'editi: insjump',

  -- Command mode
  ['c|<C-b>'] = map_cmd('<Left>'):with_noremap():with_desc 'editc: Left',
  ['c|<C-f>'] = map_cmd('<Right>'):with_noremap():with_desc 'editc: Right',
  ['c|<C-a>'] = map_cmd('<Home>'):with_noremap():with_desc 'editc: Home',
  ['c|<C-e>'] = map_cmd('<End>'):with_noremap():with_desc 'editc: End',
  ['c|<C-d>'] = map_cmd('<Del>'):with_noremap():with_desc 'editc: Delete',
  ['c|<C-h>'] = map_cmd('<BS>'):with_noremap():with_desc 'editc: Backspace',
  ['c|<C-t>'] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
    :with_noremap()
    :with_desc 'editc: Complete path of current file',

  -- Visual mode
  ['v|J'] = map_cmd(":m '>+1<CR>gv=gv"):with_desc 'editv: Move this line down',
  ['v|K'] = map_cmd(":m '<-2<CR>gv=gv"):with_desc 'editv: Move this line up',
  ['v|<'] = map_cmd('<gv'):with_desc 'editv: Decrease indent',
  ['v|>'] = map_cmd('>gv'):with_desc 'editv: Increase indent',

  -- X mode
  ['x|/'] = map_cmd('<Esc>/\\%V'):with_desc 'search within visual selection',
}

bind.nvim_load_mapping(builtins)
