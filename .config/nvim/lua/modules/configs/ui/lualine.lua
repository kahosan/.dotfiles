return function()
  local icons = {
    misc = require('modules.utils.icons').get('misc', true),
  }

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local components = {
    ctime = {
      function()
        return os.date('%H:%M:%S', os.time())
      end,
      padding = 1,
    },

    filetype = {
      function()
        return vim.bo.filetype
      end,
      colored = true,
    },

    diagnostics = {
      'diagnostics',
      source = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = {
        error = 'E=',
        warn = 'W=',
        info = 'I=',
        hint = 'H=',
      },
    },

    fileformat = {
      'fileformat',
      symbols = {
        unix = 'LF',
        dos = 'CRLF',
        mac = 'CR', -- Legacy macOS
      },
    },

    python_venv = {
      function()
        local function env_cleanup(venv)
          if string.find(venv, '/') then
            local final_venv = venv
            for w in venv:gmatch '([^/]+)' do
              final_venv = w
            end
            venv = final_venv
          end
          return venv
        end

        if vim.bo.filetype == 'python' then
          local venv = os.getenv 'CONDA_DEFAULT_ENV'
          if venv then
            return icons.misc.PyEnv .. env_cleanup(venv)
          end
          venv = os.getenv 'VIRTUAL_ENV'
          if venv then
            return icons.misc.PyEnv .. env_cleanup(venv)
          end
        end
        return ''
      end,
    },
  }

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      disabled_filetypes = { statusline = { 'alpha' } },
      component_separators = { left = '|', right = '|' },
      section_separators = { left = ' ', right = ' ' },
      -- section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', { 'diff', source = diff_source }, components.diagnostics },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', components.fileformat, 'location' },
      lualine_y = { 'progress', components.python_venv },
      lualine_z = { components.ctime },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  }
end
