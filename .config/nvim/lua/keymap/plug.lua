local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_callback = bind.map_callback

local spicker = Snacks.picker.pick

local mappings = {
  buffer = {
    -- nvim-bufdel
    ['n|<leader>bd'] = map_cr('BufDel'):with_noremap():with_silent():with_desc 'buffer: Close current',
    -- Buffer Change
    ['n|<Tab>'] = map_cr('bnext'):with_noremap():with_silent():with_desc 'buffer: Switch to next',
    ['n|<S-Tab>'] = map_cr('bprev'):with_noremap():with_silent():with_desc 'buffer: Switch to prev',
  },
  neotree = {
    -- Plugin Neotree
    ['n|<C-n>'] = map_cr('Neotree toggle'):with_noremap():with_silent():with_desc 'filetree: Toggle',
    ['n|<leader>e'] = map_cr('Neotree reveal'):with_noremap():with_silent():with_desc 'filetree: Reveal',
  },
  snacks_picker = {
    ['n|gt'] = map_callback(function()
        spicker 'diagnostics_buffer'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'lsp: Toggle diagnostics list',
    ['n|<leader>fu'] = map_callback(function()
        spicker 'undo'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Find undo history',
    ['n|<leader>fr'] = map_callback(function()
        spicker 'recent'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: File by frecency',
    ['n|<leader>fp'] = map_callback(function()
        spicker 'project'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Find project',
    ['n|<leader>fw'] = map_callback(function()
        spicker 'grep'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in project',
    ['x|<leader>fw'] = map_callback(function()
        spicker 'grep_word'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in project by select word',
    ['x|<leader>fs'] = map_callback(function()
        spicker 'lines'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in buffer by select word',
    ['n|<leader>ff'] = map_callback(function()
        spicker 'files'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: File in project',
    ['n|<leader>fc'] = map_callback(function()
        spicker 'colorschemes'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'ui: Change colorscheme for current session',
    ['n|<leader>fg'] = map_callback(function()
        spicker 'git_files'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: file in git project',
    ['n|<leader>fz'] = map_callback(function()
        spicker 'zoxide'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'editn: Change current directory by zoxide',
    ['n|<leader>fb'] = map_callback(function()
        spicker 'buffers'
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Buffer opened',
    ['n|<leader>fa'] = map_callback(function()
        spicker()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Select picker source',
    ['n|<C-p>'] = map_callback(function()
        spicker 'keymaps'
      end)
      :with_silent()
      :with_noremap()
      :with_desc 'tool: Toggle command panel',
  },
  spectre = {
    ['n|<leader>S'] = map_cr("lua require('spectre').toggle()")
      :with_silent()
      :with_noremap()
      :with_desc 'tool: Toggle Spectre',
    ['n|<leader>sp'] = map_cr("lua require('spectre').open_file_search({select_word=true})")
      :with_silent()
      :with_noremap()
      :with_desc 'tool: Search and replace on current file',
    ['v|<leader>sw'] = map_cr("lua require('spectre').open_visual()")
      :with_silent()
      :with_noremap()
      :with_desc 'tool: Search and replace current word',
  },
}

for _, plug in pairs(mappings) do
  bind.nvim_load_mapping(plug)
end
