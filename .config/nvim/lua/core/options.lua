local global = require("core.global")

local function load_options()
  local global_local = {
    -- My Setting
    number = true,                -- show line number
    relativenumber = true,        -- show relative line number
    autoindent = true,            -- auto indent
    smartindent = true,           -- smart indent
    tabstop = 2,                  -- tab width
    softtabstop = 2,              -- tab width
    shiftwidth = 2,               -- tab width
    expandtab = true,             -- use space instead of tab
    encoding = "UTF-8",           -- encoding
    syntax = "on",                -- syntax highlight
    showmatch = true,             -- highlight matching parenthesis
    hlsearch = true,              -- highlight search result
    ignorecase = true,            -- ignore case when searching
    sidescrolloff = 5,            -- keep 5 lines when scrolling horizontally
    scrolloff = 5,                -- keep 5 lines when scrolling vertically
    mouse = "a",                  -- enable mouse
    cursorline = true,            -- highlight current line
    cursorlineopt = "screenline", -- highlight current line
    termguicolors = true,         -- enable true color support
    wrap = false,                 -- wrap lines
    pumheight = 6,                -- limit completion items
    clipboard = "unnamedplus",    -- use system clipboard
  }
  local function isempty(s)
    return s == nil or s == ""
  end

  -- custom python provider
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if not isempty(conda_prefix) then
    vim.g.python_host_prog = conda_prefix .. "/bin/python"
    vim.g.python3_host_prog = conda_prefix .. "/bin/python"
  else
    vim.g.python_host_prog = "python"
    vim.g.python3_host_prog = "python3"
  end

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end

  -- Fix sqlite3 missing-lib issue on Windows
  if global.is_windows then
    -- Download the DLLs form https://www.sqlite.org/download.html
    vim.g.sqlite_clib_path = global.home .. "/Documents/sqlite-dll-win64-x64-3400200/sqlite3.dll"
  end
end

load_options()
