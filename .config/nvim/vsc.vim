" default keymap
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nnoremap gh <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

" options
set clipboard=unnamedplus,

