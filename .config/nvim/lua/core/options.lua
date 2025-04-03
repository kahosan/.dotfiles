local global = require 'core.global'
local o = vim.opt

-- General
o.autowrite = true
o.clipboard = 'unnamedplus'
o.completeopt = 'menuone,noselect,popup'
o.formatoptions = '1jcroqlnt'
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --hidden --vimgrep --smart-case --'
o.ignorecase = true
o.history = 2000
o.scrolloff = 12
-- o.jumpoptions = 'stack'
o.sessionoptions = 'buffers,curdir,tabpages,winpos,winsize'
o.smartcase = true
o.swapfile = false
o.switchbuf = 'usetab,uselast'
o.timeoutlen = 300
o.undodir = global.cache_dir .. '/undo/'
o.undofile = true
o.updatetime = 200
o.whichwrap = 'h,l,<,>,[,],~'
-- o.wildignore =
--   '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
-- o.wildignorecase = true
o.confirm = true

-- Indent
o.shiftround = true
o.shiftwidth = 4
o.expandtab = true
o.tabstop = 4
o.smartindent = true
o.autoindent = true

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.cmdheight = 1
o.showmode = false
o.cmdwinheight = 5
o.laststatus = 3
o.list = false
-- o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
o.listchars = 'space:·,extends:→,tab:»·'
o.title = true
o.titlestring = '%{fnamemodify(getcwd(), ":t")} %{expand("%:t")}'
o.mousescroll = 'ver:3,hor:6'
o.pumblend = 0
o.pumheight = 10 -- 弹出菜单中显示的最大条目数
-- o.shortmess:append { W = true, I = true, c = true }
o.shortmess = 'aoOTIcF'
o.showtabline = 2
o.sidescrolloff = 8
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.wrap = false
o.conceallevel = 3
o.winminwidth = 5

if vim.fn.has 'nvim-0.9.0' == 1 then
  o.splitkeep = 'screen'
  o.shortmess:append { C = true }
end

-- 设置 netrw 的列表样式为 3（树状视图）
-- 参考：https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
vim.g.netrw_liststyle = 3
vim.g.mapleader = ';'
