if not vim.g.vscode and not vim.g.kitty then
  require 'core'
end

if vim.g.kitty then
  require 'core.kitty'
end
