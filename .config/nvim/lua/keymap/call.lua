local bind = require("keymap.bind")
local map_callback = bind.map_callback

--- The following code enables this file to be exported ---
---  for use with gitsigns lazy-loaded keymap bindings  ---

local M = {}

function M.gitsigns(bufnr)
  local gitsigns = require("gitsigns")
  local map = {
    ["n|]g"] = map_callback(function()
        if vim.wo.diff then
          return "]g"
        end
        vim.schedule(function()
          gitsigns.nav_hunk("next")
        end)
        return "<Ignore>"
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_expr()
      :with_desc("git: Goto next hunk"),
    ["n|[g"] = map_callback(function()
        if vim.wo.diff then
          return "[g"
        end
        vim.schedule(function()
          gitsigns.nav_hunk("prev")
        end)
        return "<Ignore>"
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_expr()
      :with_desc("git: Goto prev hunk"),
    ["n|<leader>gs"] = map_callback(function()
        gitsigns.stage_hunk()
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Toggle staging/unstaging of hunk"),
    ["v|<leader>gs"] = map_callback(function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Toggle staging/unstaging of selected hunk"),
    ["n|<leader>gr"] = map_callback(function()
        gitsigns.reset_hunk()
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Reset hunk"),
    ["v|<leader>gr"] = map_callback(function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Reset hunk"),
    ["n|<leader>gR"] = map_callback(function()
        gitsigns.reset_buffer()
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Reset buffer"),
    ["n|<leader>gp"] = map_callback(function()
        gitsigns.preview_hunk()
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Preview hunk"),
    ["n|<leader>gb"] = map_callback(function()
        gitsigns.blame_line({ full = true })
      end)
      :with_buffer(bufnr)
      :with_noremap()
      :with_desc("git: Blame line"),
    -- Text objects
    ["ox|ih"] = map_callback(function()
        gitsigns.select_hunk()
      end)
      :with_buffer(bufnr)
      :with_noremap(),
  }
  bind.nvim_load_mapping(map)
end

return M
