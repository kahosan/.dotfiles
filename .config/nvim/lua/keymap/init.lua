local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function command_panel()
  local opts = {
    lhs_filter = function(lhs)
      return not string.find(lhs, "Þ")
    end,
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = "top",
    },
  }
  require("telescope.builtin").keymaps(opts)
end

local plug_map = {
  -- nvim-bufdel
  ["n|<leader>bd"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),
  -- Buffer Change
  ["n|<C-i>"] = map_cr("bnext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
  ["n|<S-Tab>"] = map_cr("bprev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),
  -- Bufferline
  -- ["n|<leader>]"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
  -- ["n|<leader>["] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),
  -- ["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("buffer: Move current to next"),
  -- ["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("buffer: Move current to prev"),
  -- ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap():with_desc("buffer: Sort by extension"),
  -- ["n|<C-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("buffer: Goto buffer 1"),
  -- ["n|<C-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent():with_desc("buffer: Goto buffer 2"),
  -- ["n|<C-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent():with_desc("buffer: Goto buffer 3"),
  -- ["n|<C-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent():with_desc("buffer: Goto buffer 4"),
  -- ["n|<C-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent():with_desc("buffer: Goto buffer 5"),
  -- ["n|<C-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent():with_desc("buffer: Goto buffer 6"),
  -- ["n|<C-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent():with_desc("buffer: Goto buffer 7"),
  -- ["n|<C-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent():with_desc("buffer: Goto buffer 8"),
  -- ["n|<C-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent():with_desc("buffer: Goto buffer 9"),
  -- Lazy.nvim
  ["n|<leader>ph"] = map_cr("Lazy"):with_silent():with_noremap():with_nowait():with_desc("package: Show"),
  ["n|<leader>ps"] = map_cr("Lazy sync"):with_silent():with_noremap():with_nowait():with_desc("package: Sync"),
  ["n|<leader>pu"] = map_cr("Lazy update"):with_silent():with_noremap():with_nowait():with_desc("package: Update"),
  ["n|<leader>pi"] = map_cr("Lazy install"):with_silent():with_noremap():with_nowait():with_desc("package: Install"),
  ["n|<leader>pl"] = map_cr("Lazy log"):with_silent():with_noremap():with_nowait():with_desc("package: Log"),
  ["n|<leader>pc"] = map_cr("Lazy check"):with_silent():with_noremap():with_nowait():with_desc("package: Check"),
  ["n|<leader>pd"] = map_cr("Lazy debug"):with_silent():with_noremap():with_nowait():with_desc("package: Debug"),
  ["n|<leader>pp"] = map_cr("Lazy profile"):with_silent():with_noremap():with_nowait():with_desc("package: Profile"),
  ["n|<leader>pr"] = map_cr("Lazy restore"):with_silent():with_noremap():with_nowait():with_desc("package: Restore"),
  ["n|<leader>px"] = map_cr("Lazy clean"):with_silent():with_noremap():with_nowait():with_desc("package: Clean"),
  -- Lsp mapp work when insertenter and lsp start
  ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait():with_desc("lsp: Info"),
  ["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait():with_desc("lsp: Restart"),
  ["n|<leader>k"] = map_callback(function()
      vim.diagnostic.open_float()
    end)
    :with_noremap()
    :with_silent()
    :with_nowait()
    :with_desc("lsp diagnostic info"),
  ["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: Open git-fugitive"),
  -- Plugin trouble
  ["n|gt"] = map_cr("Trouble diagnostics toggle filter.buf=0")
    :with_noremap()
    :with_silent()
    :with_desc("lsp: Toggle trouble list"),
  -- ["n|gh"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent():with_desc("lsp: lsp_references"),
  -- Plugin Neotree
  ["n|<C-n>"] = map_cr("Neotree toggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
  -- Plugin Telescope
  ["n|<leader>u"] = map_callback(function()
      require("telescope").extensions.undo.undo()
    end)
    :with_noremap()
    :with_silent()
    :with_desc("editn: Show undo history"),
  ["n|<leader>fp"] = map_callback(function()
      require("telescope").extensions.projects.projects({})
    end)
    :with_noremap()
    :with_silent()
    :with_desc("find: Project"),
  ["n|<leader>fr"] = map_callback(function()
      require("telescope").extensions.frecency.frecency()
    end)
    :with_noremap()
    :with_silent()
    :with_desc("find: File by frecency"),
  ["n|<leader>fw"] = map_callback(function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end)
    :with_noremap()
    :with_silent()
    :with_desc("find: Word in project"),
  ["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
  ["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
  ["n|<leader>fc"] = map_cu("Telescope colorscheme")
    :with_noremap()
    :with_silent()
    :with_desc("ui: Change colorscheme for current session"),
  ["n|<leader>fn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),
  ["n|<leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent():with_desc("find: file in git project"),
  ["n|<leader>fz"] = map_cu("Telescope zoxide list")
    :with_noremap()
    :with_silent()
    :with_desc("editn: Change current direrctory by zoxide"),
  ["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
  ["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),
  -- Plugin EasyAlign
  ["n|gea"] = map_callback(function()
      return t("<Plug>(EasyAlign)")
    end)
    :with_expr()
    :with_desc("editn: Align with delimiter"),
  ["x|gea"] = map_callback(function()
      return t("<Plug>(EasyAlign)")
    end)
    :with_expr()
    :with_desc("editx: Align with delimiter"),
  -- Plugin MarkdownPreview
  ["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_desc("tool: Preview markdown"),
  -- Plugin auto_session
  ["n|<leader>ss"] = map_cu("SaveSession"):with_noremap():with_silent():with_desc("session: Save"),
  ["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent():with_desc("session: Restore"),
  ["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent():with_desc("session: Delete"),
  -- Plugin SnipRun
  ["v|<leader>r"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
  ["n|<leader>r"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),
  ["o|m"] = map_callback(function()
    require("tsht").nodes()
  end):with_silent(),
  -- Plugin Diffview
  ["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
  ["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),
  ["n|<C-p>"] = map_callback(command_panel):with_silent():with_noremap():with_desc("tool: Toggle command panel"),
  -- Plugin Comment.nvim
  ["n|gc"] = map_callback(function()
      return vim.v.count == 0 and t("<Plug>(comment_toggle_linewise_current)")
        or t("<Plug>(comment_toggle_linewise_count)")
    end)
    :with_silent()
    :with_noremap()
    :with_expr()
    :with_desc("editn: Toggle comment for line"),
  ["n|gbc"] = map_callback(function()
      return vim.v.count == 0 and t("<Plug>(comment_toggle_blockwise_current)")
        or t("<Plug>(comment_toggle_blockwise_count)")
    end)
    :with_silent()
    :with_noremap()
    :with_expr()
    :with_desc("editn: Toggle comment for block"),
  ["n|gcc"] = map_cmd("<Plug>(comment_toggle_linewise)")
    :with_silent()
    :with_noremap()
    :with_desc("editn: Toggle comment for line with operator"),
  ["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
    :with_silent()
    :with_noremap()
    :with_desc("editn: Toggle comment for block with operator"),
  ["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
    :with_silent()
    :with_noremap()
    :with_desc("editx: Toggle comment for line with selection"),
  ["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
    :with_silent()
    :with_noremap()
    :with_desc("editx: Toggle comment for block with selection"),
}

bind.nvim_load_mapping(plug_map)
