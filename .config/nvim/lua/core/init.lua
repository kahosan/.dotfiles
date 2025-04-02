local global = require 'core.global'
local settings = require 'core.settings'
local set_opts = vim.api.nvim_set_option_value

-- Create cache dir and data dirs
local data_dirs = {
  global.cache_dir .. '/backup',
  global.cache_dir .. '/session',
  global.cache_dir .. '/swap',
  global.cache_dir .. '/tags',
  global.cache_dir .. '/undo',
}
-- Only check whether cache_dir exists, this would be enough.
if vim.fn.isdirectory(global.cache_dir) == 0 then
  vim.fn.mkdir(global.cache_dir, 'p')
  for _, dir in pairs(data_dirs) do
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end
end

if global.is_mac then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
    paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
    cache_enabled = 0,
  }
elseif global.is_wsl then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

if global.is_windows then
  if not (vim.fn.executable 'pwsh' == 1 or vim.fn.executable 'powershell' == 1) then
    vim.notify(
      [[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
      vim.log.levels.WARN,
      { title = '[core] Runtime Warning' }
    )
    return
  end

  local basecmd = '-NoLogo -MTA -ExecutionPolicy RemoteSigned'
  local ctrlcmd = '-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8'
  set_opts('shell', vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell', {})
  set_opts('shellcmdflag', string.format('%s %s;', basecmd, ctrlcmd), {})
  set_opts('shellredir', '-RedirectStandardOutput %s -NoNewWindow -Wait', {})
  set_opts('shellpipe', '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode', {})
  set_opts('shellquote', '', {})
  set_opts('shellxquote', '', {})
end

require 'core.options'
require 'core.pack'
require 'core.event'
require 'keymap'

set_opts('background', settings.background, {})
vim.cmd.colorscheme(settings.colorscheme)
