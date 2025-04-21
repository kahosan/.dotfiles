local bind = require 'keymap.bind'
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function command_panel()
  local opts = {
    lhs_filter = function(lhs)
      return not string.find(lhs, 'Þ')
    end,
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = 'top',
    },
  }
  require('telescope.builtin').keymaps(opts)
end

local mappings = {
  buffer = {
    -- nvim-bufdel
    ['n|<leader>bd'] = map_cr('BufDel'):with_noremap():with_silent():with_desc 'buffer: Close current',
    -- Buffer Change
    ['n|<C-i>'] = map_cr('bnext'):with_noremap():with_silent():with_desc 'buffer: Switch to next',
    ['n|<S-Tab>'] = map_cr('bprev'):with_noremap():with_silent():with_desc 'buffer: Switch to prev',
  },
  trouble = {
    -- Plugin trouble
    ['n|gt'] = map_cr('Trouble diagnostics toggle filter.buf=0')
      :with_noremap()
      :with_silent()
      :with_desc 'lsp: Toggle trouble list',
  },
  neotree = {
    -- Plugin Neotree
    ['n|<C-n>'] = map_cr('Neotree toggle'):with_noremap():with_silent():with_desc 'filetree: Toggle',
    ['n|<leader>e'] = map_cr('Neotree reveal'):with_noremap():with_silent():with_desc 'filetree: Reveal',
  },
  telescope = {
    -- Plugin Telescope
    ['n|<leader>fl'] = map_cr('Telescope lsp_references'):with_noremap():with_silent():with_desc 'lsp: lsp_references',
    ['n|<leader>u'] = map_callback(function()
        require('telescope').extensions.undo.undo()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'editn: Show undo history',
    ['n|<leader>fr'] = map_callback(function()
        require('telescope').extensions.frecency.frecency()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: File by frecency',
    ['n|<leader>fw'] = map_callback(function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in project',
    ['x|<leader>fw'] = map_callback(function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in project by select_word',
    ['x|<leader>fs'] = map_callback(function()
        require('telescope-live-grep-args.shortcuts').grep_word_visual_selection_current_buffer()
      end)
      :with_noremap()
      :with_silent()
      :with_desc 'find: Word in buffer by select_word',
    ['n|<leader>fe'] = map_cu('Telescope oldfiles'):with_noremap():with_silent():with_desc 'find: File by history',
    ['n|<leader>ff'] = map_cu('Telescope find_files'):with_noremap():with_silent():with_desc 'find: File in project',
    ['n|<leader>fc'] = map_cu('Telescope colorscheme')
      :with_noremap()
      :with_silent()
      :with_desc 'ui: Change colorscheme for current session',
    ['n|<leader>fg'] = map_cu('Telescope git_files'):with_noremap():with_silent():with_desc 'find: file in git project',
    ['n|<leader>fz'] = map_cu('Telescope zoxide list')
      :with_noremap()
      :with_silent()
      :with_desc 'editn: Change current directory by zoxide',
    ['n|<leader>fb'] = map_cu('Telescope buffers'):with_noremap():with_silent():with_desc 'find: Buffer opened',
    ['n|<C-p>'] = map_callback(command_panel):with_silent():with_noremap():with_desc 'tool: Toggle command panel',
  },
  spectre = {
    ['n|<leader>S'] = map_cr("lua require('spectre').toggle()"):with_silent():with_noremap():with_desc 'Toggle Spectre',
    ['n|<leader>sp'] = map_cr("lua require('spectre').open_file_search({select_word=true})")
      :with_silent()
      :with_noremap()
      :with_desc 'Search on current file',
    ['v|<leader>sw'] = map_cr("lua require('spectre').open_visual()")
      :with_silent()
      :with_noremap()
      :with_desc 'Search current word',
  },
}

for _, plug in pairs(mappings) do
  bind.nvim_load_mapping(plug)
end
