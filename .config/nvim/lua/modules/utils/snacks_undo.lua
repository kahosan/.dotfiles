local M = {}

local function notify(level, msg)
  vim.notify(msg, level, { title = 'Snacks Undo' })
end

local function cleanup(tmpbuf, tmp_file, tmp_undo)
  if tmpbuf and vim.api.nvim_buf_is_valid(tmpbuf) then
    pcall(vim.api.nvim_buf_delete, tmpbuf, { force = true })
  end
  pcall(vim.fn.delete, tmp_file)
  pcall(vim.fn.delete, tmp_undo)
end

local function get_undo_lines(buf, seq)
  local tmp_file = vim.fn.tempname()
  local tmp_undo = tmp_file .. '.undo'
  local tmpbuf

  local ok, lines_or_err = xpcall(function()
    local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if vim.fn.writefile(current_lines, tmp_file) ~= 0 then
      error 'failed to write temporary buffer'
    end

    tmpbuf = vim.fn.bufadd(tmp_file)
    vim.fn.bufload(tmpbuf)

    vim.api.nvim_buf_call(buf, function()
      vim.cmd('silent wundo! ' .. vim.fn.fnameescape(tmp_undo))
    end)
    -- 将撤销树加载到临时 buffer 并回滚到指定序号
    vim.api.nvim_buf_call(tmpbuf, function()
      vim.cmd('silent rundo ' .. vim.fn.fnameescape(tmp_undo))
      vim.cmd('noautocmd silent undo ' .. seq)
    end)

    return vim.api.nvim_buf_get_lines(tmpbuf, 0, -1, false)
  end, debug.traceback)

  cleanup(tmpbuf, tmp_file, tmp_undo)
  return ok and lines_or_err or nil, lines_or_err
end

local function create_snapshot_buf(buf, kind, lines)
  local file = vim.api.nvim_buf_get_name(buf)
  local name = file ~= '' and vim.fn.fnamemodify(file, ':t') or '[No Name]'
  local snapshot = vim.api.nvim_create_buf(false, true)

  local buf_name = ('undf_%s'):format(kind == 'current' and 'c' or 'u', name)
  if not pcall(vim.api.nvim_buf_set_name, snapshot, buf_name) then
    vim.api.nvim_buf_set_name(snapshot, buf_name .. '#' .. snapshot)
  end

  vim.api.nvim_buf_set_lines(snapshot, 0, -1, false, lines)
  vim.bo[snapshot].buftype = 'nofile'
  vim.bo[snapshot].bufhidden = 'wipe'
  vim.bo[snapshot].filetype = vim.bo[buf].filetype
  vim.bo[snapshot].modifiable = false
  return snapshot
end

local function open_diff_view(buf, undo_lines, source_win)
  local current_buf = create_snapshot_buf(buf, 'current', vim.api.nvim_buf_get_lines(buf, 0, -1, false))
  local undo_buf = create_snapshot_buf(buf, 'undo', undo_lines)

  vim.cmd('tabedit +buffer' .. current_buf)
  local current_win = vim.api.nvim_get_current_win()
  local diff_tab = vim.api.nvim_get_current_tabpage()

  vim.cmd('rightbelow vertical sbuffer ' .. undo_buf)
  local undo_win = vim.api.nvim_get_current_win()

  local win_opts = { 'number', 'relativenumber', 'cursorline' }
  for _, win in ipairs { current_win, undo_win } do
    for _, opt in ipairs(win_opts) do
      vim.wo[win][opt] = vim.wo[source_win][opt]
    end
    vim.wo[win].signcolumn = 'no'
    vim.wo[win].foldcolumn = '0'
    vim.api.nvim_win_call(win, function()
      vim.cmd 'diffthis'
    end)
  end

  for _, win in ipairs { current_win, undo_win } do
    vim.api.nvim_create_autocmd('WinClosed', {
      pattern = tostring(win),
      once = true,
      callback = function()
        vim.schedule(function()
          if vim.api.nvim_tabpage_is_valid(diff_tab) then
            pcall(vim.cmd, 'tabclose ' .. vim.api.nvim_tabpage_get_number(diff_tab))
          end
        end)
      end,
    })
  end

  vim.cmd 'diffupdate'
end

function M.diff_current(picker, item)
  item = item or picker:current()
  if not (item and item.buf and item.seq) then
    return notify(vim.log.levels.WARN, 'No undo entry selected')
  end

  local lines, err = get_undo_lines(item.buf, item.seq)
  if not lines then
    return notify(vim.log.levels.ERROR, err)
  end

  if vim.deep_equal(lines, vim.api.nvim_buf_get_lines(item.buf, 0, -1, false)) then
    return notify(vim.log.levels.INFO, 'Undo state matches current buffer')
  end

  local source_win = picker.main
  picker:close()

  vim.schedule(function()
    open_diff_view(item.buf, lines, source_win)
  end)
end

return M
