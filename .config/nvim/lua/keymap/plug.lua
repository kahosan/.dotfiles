local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_cb = bind.map_callback

local function oil_pick(source, opts)
  return function()
    opts = opts or {}
    if vim.bo.filetype == 'oil' then
      opts.cwd = require('oil').get_current_dir()
    end
    Snacks.picker.pick(source, opts)
  end
end

local mappings = {
  buffer = {
    -- nvim-bufdel
    ['n|<leader>bd'] = map_cr('BufDel'):with_noremap():with_silent():with_desc 'buffer: Close current',
    ['n|<leader>bD'] = map_cr('BufDelOthers'):with_noremap():with_silent():with_desc 'buffer: Close others',
    -- Buffer Change
    ['n|<Tab>'] = map_cr('bnext'):with_noremap():with_silent():with_desc 'buffer: Switch to next',
    ['n|<S-Tab>'] = map_cr('bprev'):with_noremap():with_silent():with_desc 'buffer: Switch to prev',
  },
  neotree = {
    -- Plugin Neotree
    ['n|<C-n>'] = map_cr('Neotree toggle'):with_noremap():with_silent():with_desc 'filetree: Toggle',
    ['n|<leader>e'] = map_cr('Neotree reveal'):with_noremap():with_silent():with_desc 'filetree: Reveal',
  },
  oil = {
    ['n|-'] = map_cr('Oil'):with_noremap():with_silent():with_desc 'filetree: Toggle',
  },
  snacks_picker = {
    ['n|gt'] = map_cr("lua Snacks.picker.pick('diagnostics_buffer')")
      :with_noremap()
      :with_silent()
      :with_desc 'lsp: Toggle diagnostics list',
    ['n|<leader>fu'] = map_cr("lua Snacks.picker.pick('undo')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: Find undo history',
    ['n|<leader>fh'] = map_cr("lua Snacks.picker.pick('help')"):with_noremap():with_silent():with_desc 'find: Find help',
    ['n|<leader>fr'] = map_cr("lua Snacks.picker.pick('recent')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: File by frecency',
    ['n|<leader>fp'] = map_cr("lua Snacks.picker.pick('project')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: Find project',
    ['n|<leader>fw'] = map_cb(oil_pick 'grep'):with_noremap():with_silent():with_desc 'find: Word in project',
    ['x|<leader>fw'] = map_cb(oil_pick 'grep_word')
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in project by select word',
    ['n|<leader>ff'] = map_cb(oil_pick 'files'):with_noremap():with_silent():with_desc 'find: File in project',
    ['n|<leader>fs'] = map_cr("lua Snacks.picker.pick('lines')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in buffer by select word',
    ['n|<leader>fc'] = map_cr("lua Snacks.picker.pick('colorschemes')")
      :with_noremap()
      :with_silent()
      :with_desc 'ui: Change colorscheme for current session',
    ['n|<leader>fg'] = map_cr("lua Snacks.picker.pick('git_files')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: file in git project',
    ['n|<leader>fz'] = map_cr("lua Snacks.picker.pick('zoxide')")
      :with_noremap()
      :with_silent()
      :with_desc 'editn: Change current directory by zoxide',
    ['n|<leader>fb'] = map_cr("lua Snacks.picker.pick('buffers')")
      :with_noremap()
      :with_silent()
      :with_desc 'find: Buffer opened',
    ['n|<leader>fa'] = map_cr('lua Snacks.picker.pick()')
      :with_noremap()
      :with_silent()
      :with_desc 'find: Select picker source',
    ['n|<C-p>'] = map_cr("lua Snacks.picker.pick('keymaps')")
      :with_silent()
      :with_noremap()
      :with_desc 'tool: Toggle command panel',
  },
  snacks_terminal = {
    ['n|<C-t>'] = map_cr('lua Snacks.terminal()'):with_noremap():with_silent():with_desc 'terminal: Toggle terminal',
  },
  grug_far = {
    ['n|<leader>S'] = map_cr("lua require('grug-far').open({transient=true})")
      :with_noremap()
      :with_silent()
      :with_desc 'replace: Open grug-far',
    ['n|<leader>sw'] = map_cr("lua require('grug-far').open({prefills={search=vim.fn.expand('<cword>')}})")
      :with_noremap()
      :with_silent()
      :with_desc 'replace: Search word in project',
    ['x|<leader>sw'] = map_cr("lua require('grug-far').with_visual_selection({prefills={paths=vim.fn.expand('%')}})")
      :with_noremap()
      :with_silent()
      :with_desc 'replace: Search word in current file by select word',
    ['n|<leader>sf'] = map_cr("lua require('grug-far').open({prefills={paths=vim.fn.expand('%')}})")
      :with_noremap()
      :with_silent()
      :with_desc 'replace: Search word in current file',
  },
  compile_mode = {
    ['n|cm'] = map_cmd('<Cmd>Compile<CR>'):with_noremap():with_silent():with_desc 'tool: Compile command',
  },
  attempt = {
    ['n|<leader>ti'] = map_cr("lua require('attempt').new_input_ext()"):with_silent():with_desc 'tool: Create scratch',
    ['n|<leader>td'] = map_cr("lua require('attempt').delete_buf()"):with_silent():with_desc 'tool: Delete scratch',
    ['n|<leader>tr'] = map_cr("lua require('attempt').rename_buf()"):with_silent():with_desc 'tool: Rename scratch',
    ['n|<leader>tl'] = map_cr("lua require('attempt.snacks').picker()"):with_silent():with_desc 'tool: Select scratch',
  },
}

for _, plug in pairs(mappings) do
  bind.nvim_load_mapping(plug)
end
