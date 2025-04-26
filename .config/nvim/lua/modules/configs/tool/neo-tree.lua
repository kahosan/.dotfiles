return function()
  ---@module "neo-tree"
  ---@type neotree.Config
  local opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style = CUSTOM_BORDER,
    default_component_configs = {
      diagnostics = {
        symbols = {
          hint = '',
          info = '',
          warn = '',
          error = '',
        },
      },
      icon = {
        folder_closed = '󰉋',
        folder_open = '󰉖',
        folder_empty = '󱧴',
        folder_empty_open = '󰉖',
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = '󰉢',
      },
      git_status = {
        symbols = {
          -- Change type
          added = 'A', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = 'M', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = 'D', -- this can only be used in the git_status source
          renamed = 'R', -- this can only be used in the git_status source
          -- Status type
          untracked = 'U',
          ignored = 'IG',
          unstaged = 'u',
          staged = 'S',
          conflict = 'C',
        },
      },
    },
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-custom-commands-global`
    commands = {},
    window = {
      position = 'left',
      width = 28,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['l'] = 'open',
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_by_name = {
          '.git',
          'node_modules',
        },
      },
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
          -- ["D"] = "fuzzy_sorter_directory",
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ['<down>'] = 'move_cursor_down',
          ['<C-n>'] = 'move_cursor_down',
          ['<up>'] = 'move_cursor_up',
          ['<C-p>'] = 'move_cursor_up',
        },
      },

      commands = {}, -- Add a custom command or override a global one using the same function name
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
          ['oc'] = { 'order_by_created', nowait = false },
          ['od'] = { 'order_by_diagnostics', nowait = false },
          ['om'] = { 'order_by_modified', nowait = false },
          ['on'] = { 'order_by_name', nowait = false },
          ['os'] = { 'order_by_size', nowait = false },
          ['ot'] = { 'order_by_type', nowait = false },
        },
      },
    },
  }

  -- rename by lsp
  local function on_move(data)
    Snacks.rename.on_rename_file(data.source, data.destination)
  end

  local events = require 'neo-tree.events'
  opts.event_handlers = opts.event_handlers or {}
  vim.list_extend(opts.event_handlers, {
    { event = events.FILE_MOVED, handler = on_move },
    { event = events.FILE_RENAMED, handler = on_move },
  })
  require('neo-tree').setup(opts)
end
