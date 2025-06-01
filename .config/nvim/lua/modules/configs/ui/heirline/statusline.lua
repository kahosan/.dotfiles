local comp = require 'ui.heirline.components'
local RightPadding = comp.RightPadding

return {
  -- M.RightPadding(M.Mode, 2),
  RightPadding(comp.FileNameBlock, 2),
  RightPadding(comp.Diagnostics),
  RightPadding(comp.CTime),
  RightPadding(comp.SearchOccurrence),
  comp.Fill,
  comp.MacroRecording,
  comp.Fill,
  RightPadding(comp.ShowCmd),
  RightPadding(comp.Git),
  -- M.RightPadding(M.LSPActive),
  RightPadding(comp.FileStatus),
  RightPadding(comp.SimpleIndicator),
  comp.FileType,
  RightPadding(comp.PythonVenv),
  RightPadding(comp.Ruler),
}
