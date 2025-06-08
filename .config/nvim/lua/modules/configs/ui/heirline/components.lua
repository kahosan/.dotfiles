local M = {}

local palette = require('catppuccin.palettes').get_palette 'mocha'
local utils = require 'heirline.utils'
local conditions = require 'heirline.conditions'
local colors = {
  diag_warn = utils.get_highlight('DiagnosticWarn').fg,
  diag_error = utils.get_highlight('DiagnosticError').fg,
  diag_hint = utils.get_highlight('DiagnosticHint').fg,
  diag_info = utils.get_highlight('DiagnosticInfo').fg,
  git_del = utils.get_highlight('diffDeleted').fg,
  git_add = utils.get_highlight('diffAdded').fg,
  git_change = utils.get_highlight('diffChanged').fg,
}

M.Spacer = { provider = ' ' }
M.Fill = { provider = '%=' }
M.Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = '%P (%l,%c)',
}
-- Spacing providers
M.RightPadding = function(child, num_space)
  local result = {
    condition = child.condition,
    child,
    M.Spacer,
  }
  if num_space ~= nil then
    for _ = 2, num_space do
      table.insert(result, M.Spacer)
    end
  end
  return result
end

M.Mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = '',
      no = '?',
      nov = '?',
      noV = '?',
      ['no\22'] = '?',
      niI = 'i',
      niR = 'r',
      niV = 'Nv',
      nt = '',
      v = '',
      vs = 'Vs',
      V = '-',
      Vs = 'Vs',
      ['\22'] = '\\',
      ['\22s'] = '\\',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = '',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = '',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = '',
    },
    mode_colors = {
      n = palette.blue,
      nt = palette.red,
      i = palette.green,
      v = palette.mauve,
      V = palette.mauve,
      ['\22'] = palette.mauve,
      c = palette.red,
      s = palette.pink,
      S = palette.pink,
      ['\19'] = palette.pink,
      R = palette.peach,
      r = palette.peach,
      ['!'] = palette.red,
      t = palette.green,
    },
  },
  provider = function(self)
    return '%1(' .. self.mode_names[self.mode] .. '%)'
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = palette.base, bg = self.mode_colors[mode], bold = true }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      pcall(vim.cmd, 'redrawstatus')
    end),
  },
}

M.MacroRecording = {
  condition = conditions.is_active,
  init = function(self)
    self.reg_recording = vim.fn.reg_recording()
    self.status_dict = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
    self.has_changes = (self.status_dict.added or 0) ~= 0
      or (self.status_dict.removed or 0) ~= 0
      or (self.status_dict.changed or 0) ~= 0
  end,
  {
    condition = function(self)
      return self.reg_recording ~= ''
    end,
    {
      provider = '󰻃 ',
      hl = { fg = palette.maroon },
    },
    {
      provider = function(self)
        return self.reg_recording
      end,
      hl = { fg = palette.maroon, italic = false, bold = true },
    },
    hl = { fg = palette.text, bg = palette.base },
  },
  update = { 'RecordingEnter', 'RecordingLeave' },
} -- MacroRecording

M.LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    local names = {}
    ---@diagnostic disable-next-line: deprecated
    for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
      table.insert(names, server.name)
    end
    return table.concat(names, ',')
  end,
  hl = { fg = palette.surface1, bold = false },
  -- on_click = {
  --   name = 'heirline_lsp',
  --   callback = function()
  --     vim.cmd 'LspInfo'
  --   end,
  -- },
}

M.FileType = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

-- Git
M.Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = (self.status_dict.added or 0) ~= 0
      or (self.status_dict.removed or 0) ~= 0
      or (self.status_dict.changed or 0) ~= 0
  end,

  hl = { fg = palette.text },

  { -- git branch name
    provider = function(self)
      -- return '󰘬 ' .. self.status_dict.head
      return self.status_dict.head
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '(',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count)
    end,
    hl = { fg = colors.git_add },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count)
    end,
    hl = { fg = colors.git_del },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count)
    end,
    hl = { fg = colors.git_change },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ')',
  },
  -- on_click = {
  --   name = 'heirline_git',
  --   callback = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     Snacks.lazygit { cwd = Snacks.git.get_root() }
  --   end,
  -- },
}

M.Diagnostics = {
  condition = conditions.has_diagnostics,

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

    self.sep_cond = function(diag_name)
      local c_tbl = {
        errors = function()
          return self.errors > 0
            and self.errors .. ((self.warnings > 0 or self.info > 0 or self.hints > 0) and ',' or '')
        end,
        warnings = function()
          return self.warnings > 0 and self.warnings .. ((self.info > 0 or self.hints > 0) and ',' or '')
        end,
        info = function()
          return self.info > 0 and self.info .. (self.hints > 0 and ',' or '')
        end,
      }

      return c_tbl[diag_name]()
    end
  end,

  update = { 'DiagnosticChanged', 'BufEnter' },

  -- {
  --   provider = '{ ',
  -- },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.sep_cond 'errors'
    end,
    hl = { fg = colors.diag_error },
  },
  {
    provider = function(self)
      return self.sep_cond 'warnings'
    end,
    hl = { fg = colors.diag_warn },
  },
  {
    provider = function(self)
      return self.sep_cond 'info'
    end,
    hl = { fg = colors.diag_info },
  },
  {
    provider = function(self)
      return self.hints > 0 and self.hints
    end,
    hl = { fg = colors.diag_hint },
  },
  {
    provider = ' |',
  },
}

M.FileIcon = {
  condition = function(self)
    return vim.fn.fnamemodify(self.filename, ':.') ~= ''
  end,
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    -- TODO: switch to mini.icons
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = { fg = palette.text },
}
-- we redefine the filename component, as we probably only want the tail and not the relative path
M.FileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
    return filename
  end,
  hl = { fg = palette.text },
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
M.FileFlags = {
  {
    condition = function(self)
      return vim.fn.fnamemodify(self.filename, ':.') ~= ''
        and vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
    end,
    provider = '[+]',
    hl = function(self)
      return { fg = palette.text, bold = self.is_active }
    end,
  },
}

M.FileNameBlock = {
  init = function(self)
    local bufnr = self.bufnr and self.bufnr or 0
    self.filename = vim.api.nvim_buf_get_name(bufnr)
  end,
  hl = { fg = palette.text },
  -- M.FileIcon,
  M.FileName,
  M.FileFlags,
}

M.PythonVenv = {
  provider = function()
    local function env_cleanup(venv)
      if string.find(venv, '/') then
        local final_venv = venv
        for w in venv:gmatch '([^/]+)' do
          final_venv = w
        end
        venv = final_venv
      end
      return '(' .. venv .. ')'
    end

    if vim.bo.filetype == 'python' then
      local venv = os.getenv 'CONDA_DEFAULT_ENV'
      if venv then
        return env_cleanup(venv)
      end
      venv = os.getenv 'VIRTUAL_ENV'
      if venv then
        return env_cleanup(venv)
      end
      return ''
    end
  end,
  hl = { fg = palette.green },
}

M.TablineFileNameBlock = vim.tbl_extend('force', M.FileNameBlock, {
  on_click = {
    callback = function(_, minwid, _, button)
      if button == 'm' then -- close on mouse middle click
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = 'heirline_tabline_buffer_callback',
  },
})

vim.opt.showcmdloc = 'statusline'
M.ShowCmd = {
  condition = function()
    return vim.o.cmdheight == 0
  end,
  provider = '%3.5(%S%)',
}

M.SearchOccurrence = {
  condition = function()
    return vim.v.hlsearch ~= 0
  end,
  hl = { fg = palette.sky },
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    if search ~= nil then
      return string.format('[%d/%d]', search.current, math.min(search.total, search.maxcount))
    end
    return ''
  end,
}

M.SimpleIndicator = {
  condition = function()
    return vim.g.simple_indicator_on
  end,
  hl = { fg = palette.sky },
  provider = '',
}

M.FileStatus = {
  -- {
  --   provider = '(',
  -- },
  {
    provider = function()
      local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc
    end,
  },
  -- {
  --   provider = '|',
  -- },
  -- {
  --   provider = function()
  --     local fmt = vim.bo.fileformat
  --     if fmt == 'unix' then
  --       return 'LF'
  --     elseif fmt == 'dos' then
  --       return 'CRLF'
  --     elseif fmt == 'mac' then
  --       return 'CR'
  --     end
  --   end,
  -- },
  -- {
  --   provider = ')',
  -- },
}

M.CTime = {
  provider = function()
    return os.date 'T(%H:%M)'
  end,
  hl = { fg = palette.text },
}

return M
