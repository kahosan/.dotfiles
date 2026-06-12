local os_name = vim.uv.os_uname().sysname

CUSTOM_BORDER = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }

local is_bigfile = function()
  local buf = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buf)

  local stat = vim.uv.fs_stat(path)
  if stat and stat.size > 1.5 * 1024 * 1024 then
    return true
  end
  return false
end

return {
  is_mac = os_name == 'Darwin',
  is_linux = os_name == 'Linux',
  is_windows = os_name == 'Windows_NT',
  is_wsl = vim.fn.has 'wsl' == 1,
  is_ssh = vim.env.SSH_CONNECTION ~= nil,
  vim_path = vim.fn.stdpath 'config',
  cache_dir = vim.fn.stdpath 'cache',
  data_dir = string.format('%s/site/', vim.fn.stdpath 'data'),
  modules_dir = vim.fn.stdpath 'config' .. '/modules',
  home = os_name == 'Windows_NT' and os.getenv 'USERPROFILE' or os.getenv 'HOME',
  is_bigfile = is_bigfile(),
}
