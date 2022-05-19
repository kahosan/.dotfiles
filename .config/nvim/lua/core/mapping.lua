local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
	-- Vim map
  -- Normal
  ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),
  ["n|<C-q>"] = map_cmd(":wq<CR>"),
  -- Insert

  -- Visual
  ["v|<"] = map_cmd("<gv"),
	["v|>"] = map_cmd(">gv"),
  -- Command
}

bind.nvim_load_mapping(def_map)