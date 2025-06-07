return {
  default_args = {
    DiffviewOpen = { '--imply-local' },
  },
  hooks = {
    diff_buf_win_enter = function(_, winid, _)
      -- Turn off cursor line for diffview windows because of bg conflict
      -- https://github.com/neovim/neovim/issues/9800
      vim.wo[winid].culopt = 'number'
    end,
  },
  file_history_panel = {
    win_config = {
      height = 8,
    },
  },
}
