return {
  panel = { enabled = false },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = '<C-i>',
      accept_word = '<C-j>',
      accept_line = '<C-l>',
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<C-]>',
    },
  },
  filetypes = {
    bigfile = false,
    markdown = false,
    ['grug-far'] = false,
    ['grug-far-history'] = false,
    ['grug-far-help'] = false,
  },
}
