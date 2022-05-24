local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local plug_map = {
  -- Bufferline
  ["n|<leader>]"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	["n|<leader>["] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
  ["n|bd"] = map_cr("Bdelete"):with_noremap():with_silent(),
  ["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),

  -- Packer
	["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pc"] = map_cr("PackerClean"):with_silent():with_noremap():with_nowait(),

  -- NvimTree
  ["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
	["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),

  -- Lsp mapp work when insertenter and lsp start
	["n|g["] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(),
	["n|g]"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(),
	["n|gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(),
	["n|gr"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
	["v|<leader>ca"] = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
	["n|gd"] = map_cr("Lspsaga preview_definition"):with_noremap():with_silent(),
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
	["n|gh"] = map_cr("lua vim.lsp.buf.references()"):with_noremap():with_silent(),

  -- Plugin trouble
	["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent(),
	["n|gR"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
	["n|<leader>cd"] = map_cr("TroubleToggle document_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cw"] = map_cr("TroubleToggle workspace_diagnostics"):with_noremap():with_silent(),
	["n|<leader>cq"] = map_cr("TroubleToggle quickfix"):with_noremap():with_silent(),
	["n|<leader>cl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent(),

  -- Plugin Telescope
	["n|<Leader>fp"] = map_cu("lua require('telescope').extensions.project.project{}"):with_noremap():with_silent(),
	["n|<Leader>fr"] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
	["n|<Leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent(),
	["n|<Leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<Leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent(),
	["n|<Leader>fn"] = map_cu(":enew"):with_noremap():with_silent(),
	["n|<Leader>fw"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
	["n|<Leader>fz"] = map_cu("Telescope zoxide list"):with_noremap():with_silent(),

  -- Plugin Hop
	["n|<leader>w"] = map_cu("HopWord"):with_noremap(),
	["n|<leader>j"] = map_cu("HopLine"):with_noremap(),
	["n|<leader>k"] = map_cu("HopLine"):with_noremap(),
	["n|<leader>c"] = map_cu("HopChar1"):with_noremap(),
	["n|<leader>cc"] = map_cu("HopChar2"):with_noremap(),

	-- Fterm
	["n|<leader>ft"] = map_cu('lua require("FTerm").toggle()'):with_noremap():with_silent(),
	["t|<leader>ft"] = map_cu([[<C-\><C-n><CMD>lua require("FTerm").toggle()]]):with_noremap():with_silent(),
	["t|<leader>fd"] = map_cu([[<C-\><C-n><CMD>lua require("FTerm").exit()]]):with_noremap():with_silent(),
	["n|<Leader>G"] = map_cu("lua require('FTerm').run('lazygit')"):with_noremap():with_silent(),
}

bind.nvim_load_mapping(plug_map)
