return function()
  local compile_mode = require 'compile-mode'

  vim.g.compile_mode = {
    -- bang_expansion = true,
    -- baleia_setup = true,
    default_command = '',
    input_word_completion = true,
    error_regexp_table = {
      nodejs = {
        regex = '^\\s\\+at .\\+ (\\(.\\+\\):\\([1-9][0-9]*\\):\\([1-9][0-9]*\\))$',
        filename = 1,
        row = 2,
        col = 3,
        priority = 2,
      },
      typescript = {
        regex = '^\\(.\\+\\)(\\([1-9][0-9]*\\),\\([1-9][0-9]*\\)): error TS[1-9][0-9]*:',
        filename = 1,
        row = 2,
        col = 3,
      },
      typescript_new = {
        regex = '^\\(.\\+\\):\\([1-9][0-9]*\\):\\([1-9][0-9]*\\) - error TS[1-9][0-9]*:',
        filename = 1,
        row = 2,
        col = 3,
      },
      gradlew = {
        regex = '^e:\\s\\+file://\\(.\\+\\):\\(\\d\\+\\):\\(\\d\\+\\) ',
        filename = 1,
        row = 2,
        col = 3,
      },
      ls_lint = {
        regex = '\\v^\\d{4}/\\d{2}/\\d{2} \\d{2}:\\d{2}:\\d{2} (.+) failed for rules: .+$',
        filename = 1,
      },
      sass = {
        regex = '\\s\\+\\(.\\+\\) \\(\\d\\+\\):\\(\\d\\+\\)  .*$',
        filename = 1,
        row = 2,
        col = 3,
        type = compile_mode.level.WARNING,
      },
      kotlin = {
        regex = '^\\%(e\\|w\\): file://\\(.*\\):\\(\\d\\+\\):\\(\\d\\+\\) ',
        filename = 1,
        row = 2,
        col = 3,
      },
      fd = {
        regex = '\\([/.~\\]\\?[A-Za-z0-9_-]\\+\\/.\\+$\\)',
        filename = 1,
        type = compile_mode.level.INFO,
      },
    },
  }
end
