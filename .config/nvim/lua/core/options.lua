local global = require("core.global")

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true then
      vim.cmd("set " .. k)
    elseif v == false then
      vim.cmd("set no" .. k)
    else
      vim.cmd("set " .. k .. "=" .. v)
    end
  end
end

local function load_options()
  local global_local = {
    guicursor = "i:block-iCursor-blinkon1-blinkoff1",
    termguicolors = true,
    mouse = "a",
    hidden = true,
    fileformats = "unix,mac,dos",
    magic = true,
    encoding = "utf-8",
    viewoptions = "folds,cursor,curdir,slash,unix",
    clipboard = "unnamedplus",
    wildignorecase = true,
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    backup = false,
    writebackup = false,
    swapfile = false,
    history = 2000,
    shada = "!,'300,<50,@100,s10,h",
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    timeout = true,
    ttimeout = true,
    timeoutlen = 500,
    ttimeoutlen = 0,
    updatetime = 300,
    redrawtime = 1500,
    -- whichwrap = "h,l,<,>,[,],~",
    whichwrap = "<,>,[,],~",
    completeopt = "menuone,noselect",
    shortmess = "aoOTIcF",
    scrolloff = 5,
    sidescrolloff = 5,
    mousescroll = "ver:3,hor:6",
    cursorline = true,
    pumheight = 15,
    helpheight = 12,
    previewheight = 12,
    showcmd = false,
    cmdheight = 1,
    cmdwinheight = 5,
    equalalways = false,
    laststatus = 2,
    display = "lastline",
    showbreak = "↳  ",
    listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    -- pumblend = 10,
    -- winblend = 10,
    autoread = true,
    autowrite = true,
  }
  --
  local bw_local = {
    undofile = true,
    synmaxcol = 2500,
    formatoptions = "1jcroql",
    -- textwidth = 80,
    expandtab = false,
    -- expandtab = true,
    autoindent = true,
    smartindent = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = -1,
    -- softtabstop = 2,
    breakindentopt = "shift:2,min:20",
    wrap = false,
    linebreak = true,
    number = true,
    relativenumber = true,
    foldenable = true,
    signcolumn = "yes",
    conceallevel = 0,
    concealcursor = "niv",
  }

  local function isempty(s)
    return s == nil or s == ""
  end

  -- custom python provider
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if not isempty(conda_prefix) then
    vim.g.python_host_prog = conda_prefix .. "/bin/python3"
    vim.g.python3_host_prog = conda_prefix .. "/bin/python3"
  elseif global.is_mac then
    vim.g.python_host_prog = "/usr/bin/python3"
    vim.g.python3_host_prog = "/usr/local/bin/python3"
  else
    vim.g.python_host_prog = "/usr/bin/python3"
    vim.g.python3_host_prog = "/usr/bin/python3"
  end

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

load_options()
