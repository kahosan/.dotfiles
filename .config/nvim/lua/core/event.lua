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

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local extension = vim.fn.expand("%:e")
    if
      (extension == "ts" or extension == "js")
      and vim.fn.filereadable("eslint.config.js")
      and vim.fn.exists(":EslintFixAll") == 2
    then
      vim.cmd("EslintFixAll")
    else
      vim.lsp.buf.format({ async = true, bufnr = args.buf })
    end
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
