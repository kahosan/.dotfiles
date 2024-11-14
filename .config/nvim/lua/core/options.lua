local global = require("core.global")

local function load_options()
  local global_local = {
    -- 自动缩进新行
    autoindent = false,
    -- 文件被外部修改后自动读取
    autoread = true,
    -- 在切换缓冲区或退出时自动保存文件
    autowrite = true,
    -- 允许退格键删除缩进、行尾和插入的开始位置
    backspace = "indent,eol,start",
    -- 不创建备份文件
    backup = false,
    -- 指定不进行备份的文件模式
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    -- 定义换行符
    -- breakat = [[\ \	;:,!?]],
    -- 换行缩进选项
    -- breakindentopt = "shift:2,min:20",
    -- 使用系统剪贴板
    clipboard = "unnamedplus",
    -- 命令行高度
    cmdheight = 1, -- 可选值：0, 1, 2
    -- 命令窗口高度
    cmdwinheight = 5,
    -- 自动补全设置
    complete = ".,w,b,k,kspell",
    -- 补全选项
    completeopt = "menuone,noselect,popup",
    -- 控制隐藏文本的光标显示模式
    -- concealcursor = "niv",
    -- 控制隐藏文本的显示级别
    -- conceallevel = 0,
    -- 高亮光标所在的列
    -- cursorcolumn = true,
    -- 高亮光标所在的行
    cursorline = true,
    -- 差异比较选项
    -- diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
    -- 显示设置
    -- display = "lastline",
    -- 设置文件编码
    encoding = "utf-8",
    -- 禁用窗口大小自动均等化
    equalalways = false,
    -- 启用错误铃声
    -- errorbells = true,
    -- 设定文件格式
    -- fileformats = "unix,mac,dos",
    -- 格式化选项
    -- formatoptions = "1jcroql",
    -- grep格式设置
    grepformat = "%f:%l:%c:%m",
    -- grep程序设置，使用 ripgrep
    grepprg = "rg --hidden --vimgrep --smart-case --",
    -- 帮助窗口高度
    helpheight = 12,
    -- 允许隐藏未保存的缓冲区
    hidden = true,
    -- 命令历史记录数
    history = 2000,
    -- 搜索时忽略大小写
    ignorecase = true,
    -- 增量命令显示方式
    inccommand = "nosplit",
    -- 启用增量搜索
    incsearch = true,
    -- 自动调整补全的大小写
    infercase = true,
    -- 跳转选项，使用堆栈
    jumpoptions = "stack",
    -- 总是显示状态栏
    -- laststatus = 3,
    -- 启用智能换行
    linebreak = true,
    -- 显示不可见字符
    -- list = true,
    -- 定义不可见字符的显示方式
    -- listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    -- 启用正则表达式的魔法模式
    magic = true,
    -- 鼠标滚动设置
    mousescroll = "ver:3,hor:6",
    -- 显示行号
    number = true,
    -- 预览窗口高度
    previewheight = 12,
    -- 弹出菜单透明度（不建议调整，如果您使用透明背景）
    pumblend = 0,
    -- 弹出菜单最大高度
    pumheight = 15,
    -- 重绘时间设置
    redrawtime = 1500,
    -- 显示相对行号
    relativenumber = true,
    -- 在状态栏显示光标位置
    ruler = true,
    -- 光标上下保留的最少屏幕行数
    scrolloff = 12,
    -- 会话选项，保存哪些内容
    sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize",
    -- shada 文件设置，保存历史记录等
    shada = "!,'500,<50,@100,s10,h",
    -- 缩进时对齐 shiftwidth
    shiftround = true,
    -- 设置自动缩进的宽度
    shiftwidth = 2,
    -- 缩短消息选项，减少干扰
    shortmess = "aoOTIcF",
    -- 换行符显示设置
    showbreak = "↳  ",
    -- 不在命令行显示输入的命令
    showcmd = false,
    -- 不显示模式提示
    showmode = false,
    -- 总是显示标签栏
    showtabline = 2,
    -- 光标左右保留的最少屏幕列数
    sidescrolloff = 5,
    -- 总是显示标记列
    signcolumn = "yes",
    -- 智能大小写搜索
    smartcase = true,
    -- 智能制表符，插入时根据上下文插入适当数量的空格
    smarttab = true,
    -- 启用平滑滚动
    smoothscroll = true,
    -- 水平分割窗口时，新窗口位于下方
    splitbelow = true,
    -- 分割窗口时保持屏幕内容不变
    splitkeep = "screen",
    -- 垂直分割窗口时，新窗口位于右侧
    splitright = true,
    -- 保持光标在行首
    startofline = false,
    -- 禁用交换文件
    swapfile = false,
    -- 切换缓冲区选项
    switchbuf = "usetab,uselast",
    -- 语法高亮的最大列数
    synmaxcol = 2500,
    -- 设置制表符宽度
    tabstop = 4,
    -- 启用终端的真彩色支持
    termguicolors = true,
    -- 启用映射序列的超时
    timeout = true,
    -- 映射序列的超时时间（毫秒）
    timeoutlen = 300,
    -- 启用键码序列的超时
    ttimeout = true,
    -- 键码序列的超时时间（毫秒）
    ttimeoutlen = 0,
    -- 设置撤销文件的存储目录
    undodir = global.cache_dir .. "/undo/",
    -- 启用持久化撤销
    undofile = true,
    -- 更新触发事件的时间（不建议超过500，否则插件可能无法正常工作）
    updatetime = 200,
    -- 视图选项，保存折叠、光标位置等
    viewoptions = "folds,cursor,curdir,slash,unix",
    -- 虚拟编辑模式，允许在可视块中进行虚拟编辑
    virtualedit = "block",
    -- 定义哪些键允许换行到上一行或下一行
    whichwrap = "h,l,<,>,[,],~",
    -- 文件名补全时忽略的模式
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    -- 文件名补全时忽略大小写
    wildignorecase = true,
    -- 禁用自动换行
    wrap = false,
    -- 搜索时到文件末尾后自动从头开始
    wrapscan = true,
    -- 不在写入文件前创建备份
    writebackup = false,
  }

  -- 定义辅助函数
  -- local function isempty(s)
  --     return s == nil or s == ""
  -- end
  -- local function use_if_defined(val, fallback)
  --     return val ~= nil and val or fallback
  -- end

  -- 自定义 Python 提供者
  -- local conda_prefix = os.getenv("CONDA_PREFIX")
  -- if not isempty(conda_prefix) then
  --     -- 如果设置了 CONDA_PREFIX，使用对应的 Python 解释器
  --     vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
  --     vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
  -- else
  --     -- 否则使用系统默认的 Python 解释器
  --     vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
  --     vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
  -- end
  for name, value in pairs(global_local) do
    vim.api.nvim_set_option_value(name, value, {})
  end
end

-- 设置 netrw 的列表样式为 3（树状视图）
-- 参考：https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
vim.g.netrw_liststyle = 3

-- 加载配置选项
load_options()
