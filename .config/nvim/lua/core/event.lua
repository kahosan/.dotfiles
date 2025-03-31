vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "alpha", "mason", "lazy" },
  callback = function(data)
    vim.b[data.buf].miniindentscope_disable = true
  end,
})

-- fix docker compose lsp
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "docker-compose.yaml",
    "docker-compose.yml",
  },
  command = "set filetype=yaml.docker-compose",
})

vim.api.nvim_create_augroup("setIndent", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  group = "setIndent",
  pattern = {
    "xml",
    "html",
    "xhtml",
    "css",
    "scss",
    "javascript",
    "typescript",
    "yaml",
    "lua",
    "jsx",
    "tsx",
    "typescriptreact",
    "javascriptreact",
  },
  command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})
