vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- fix docker compose lsp
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'docker-compose.yaml',
    'docker-compose.yml',
  },
  command = 'set filetype=yaml.docker-compose',
})

vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'setIndent',
  pattern = {
    'xml',
    'html',
    'xhtml',
    'css',
    'scss',
    'javascript',
    'typescript',
    'yaml',
    'lua',
    'jsx',
    'tsx',
    'typescriptreact',
    'javascriptreact',
  },
  command = 'setlocal shiftwidth=2 tabstop=2 expandtab',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('bigfile', { clear = true }),
  pattern = 'bigfile',
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      local buf = ev.buf
      local ft = vim.filetype.match { buf = ev.buf } or ''
      if vim.fn.exists ':NoMatchParen' ~= 0 then
        vim.cmd [[NoMatchParen]]
      end
      vim.b.completion = false
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.b.minianimate_disable = true
      vim.b.minihipatterns_disable = true
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.bo[buf].syntax = ft
        end
      end)
    end)
  end,
})
