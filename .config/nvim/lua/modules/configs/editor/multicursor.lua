return function()
  local mc = require 'multicursor-nvim'
  mc.setup()

  local set = vim.keymap.set

  set({ 'n', 'x' }, '<leader>n', function()
    mc.matchAddCursor(1)
  end)
  set({ 'n', 'x' }, '<leader>s', function()
    mc.matchSkipCursor(1)
  end)
  set({ 'n', 'x' }, '<leader>N', function()
    mc.matchAddCursor(-1)
  end)
  set({ 'n', 'x' }, '<leader>S', function()
    mc.matchSkipCursor(-1)
  end)
  set({ 'n', 'x' }, '<leader>A', mc.matchAllAddCursors)
  set({ 'n', 'x' }, '<up>', function()
    mc.lineAddCursor(-1)
  end)
  set({ 'n', 'x' }, '<down>', function()
    mc.lineAddCursor(1)
  end)
  set('n', '<c-leftmouse>', mc.handleMouse)

  mc.addKeymapLayer(function(layerSet)
    layerSet('n', '<esc>', function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end)
  end)
end
