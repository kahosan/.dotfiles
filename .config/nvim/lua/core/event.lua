local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {},
    bufs = {
      -- Reload vim config automatically
      {
        "BufWritePost",
        [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
      },
      -- Reload Vim script automatically if setlocal autoread
      {
        "BufWritePost,FileWritePost",
        "*.vim",
        [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
      },
      { "BufWritePre", "/tmp/*", "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },
      -- auto change directory
      { "BufEnter", "*", "silent! lcd %:p:h" },
      -- auto place to last edit
      {
        "BufReadPost",
        "*",
        [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      },
      {
        "BufEnter",
        "*",
        [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
      },
      -- Auto toggle fcitx5
      -- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
      -- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
      -- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
      -- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
      -- auto format for eslint
      {
        "BufWritePre",
        "*.tsx,*.ts,*.jsx,*.js,*.vue,*.mts,*.mjs,*.cjs,*.cts",
        "EslintFixAll",
      },
    },
    wins = {
      -- Highlight current line only on focused window
      -- {
      -- 	"WinEnter,BufEnter,InsertLeave",
      -- 	"*",
      -- 	[[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
      -- },
      -- {
      -- 	"WinLeave,BufLeave,InsertEnter",
      -- 	"*",
      -- 	[[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
      -- },
      -- Force write shada on leaving nvim
      {
        "VimLeave",
        "*",
        [[if has('nvim') | wshada! | else | wviminfo! | endif]],
      },
      -- Check if file changed when its window is focus, more eager than 'autoread'
      { "FocusGained", "* checktime" },
      -- Equalize window dimensions when resizing vim window
      { "VimResized", "*", [[tabdo wincmd =]] },
    },
    ft = {
      { "FileType", "alpha", "set showtabline=0" },
      { "FileType", "markdown", "set wrap" },
      { "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
      -- Google tab style
      { "FileType", "c,cpp", "set expandtab tabstop=4 shiftwidth=4" },
      { "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
      { "Filetype", "go", "set tabstop=4 shiftwidth=4" },
      {
        "FileType",
        "*",
        -- [[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]],
        [[setlocal formatoptions-=cro]],
      },
      {
        "FileType",
        "c,cpp",
        "nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>",
      },
    },
    yank = {
      {
        "TextYankPost",
        "*",
        [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
      },
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()

-- Winbar (for nvim 0.8+)
-- if vim.fn.has('nvim-0.8') == 1 then
--   vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
--     callback = function()
--       local winbar_filetype_exclude = {
--         "help",
--         "startify",
--         "dashboard",
--         "packer",
--         "neogitstatus",
--         "NvimTree",
--         "Trouble",
--         "alpha",
--         "lir",
--         "Outline",
--         "spectre_panel",
--         "toggleterm",
--         "TelescopePrompt",
--         "DressingInput",
--         "DressingSelect",
--         "neotest-summary",
--       }
--
--       if (vim.api.nvim_win_get_config(0).relative ~= "") then
--         return
--       end
--
--       if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
--         vim.opt_local.winbar = nil
--         return
--       end
--
--       if vim.bo.filetype == 'GitBlame' then
--         local hl_group = "EcovimSecondary"
--         vim.opt_local.winbar = " " .. "%#" .. hl_group .. "#" .. require('icons').git .. "Blame" .. "%*"
--         return
--       end
--
--       local present, winbar = pcall(require, "winbar")
--       if not present or type(winbar) == "boolean" then
--         vim.opt_local.winbar = nil
--         return
--       end
--
--       local value = winbar.gps()
--
--       if value == nil then
--         value = winbar.filename()
--       end
--
--       vim.opt_local.winbar = value
--     end,
--   })
-- end
