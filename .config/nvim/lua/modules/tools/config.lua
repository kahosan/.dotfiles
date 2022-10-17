local config = {}

function config.telescope()
  vim.cmd([[packadd sqlite.lua]])
  vim.cmd([[packadd telescope-fzf-native.nvim]])
  vim.cmd([[packadd telescope-project.nvim]])
  vim.cmd([[packadd telescope-frecency.nvim]])
  vim.cmd([[packadd telescope-zoxide]])

  local telescope_actions = require("telescope.actions.set")
  local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
      telescope_actions.select:enhance({
        post = function()
          vim.cmd(":normal! zx")
        end,
      })
      return true
    end,
  }

  require("telescope").setup({
    defaults = {
      initial_mode = "insert",
      prompt_prefix = "  ",
      selection_caret = " ",
      entry_prefix = " ",
      scroll_strategy = "limit",
      results_title = false,
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      layout_strategy = "horizontal",
      path_display = { "absolute" },
      file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
      layout_config = {
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.5,
        },
      },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    extensions = {
      fzf = {
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
      },
    },
    pickers = {
      buffers = fixfolds,
      find_files = fixfolds,
      git_files = fixfolds,
      grep_string = fixfolds,
      live_grep = fixfolds,
      oldfiles = fixfolds,
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("project")
  require("telescope").load_extension("zoxide")
  require("telescope").load_extension("frecency")
end

function config.trouble()
  require("trouble").setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = {
      -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- preview item
      next = "j", -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "﫠",
    },
    use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  })
end

function config.wilder()
  local wilder = require("wilder")
  wilder.setup({ modes = { ":", "/", "?" } })
  wilder.set_option("use_python_remote_plugin", 0)
  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline({ use_python = 0, fuzzy = 1, fuzzy_filter = wilder.lua_fzy_filter() }),
      wilder.vim_search_pipeline(),
      {
        wilder.check(function(_, x)
          return x == ""
        end),
        wilder.history(),
        wilder.result({
          draw = {
            function(_, x)
              return " " .. x
            end,
          },
        }),
      }
    ),
  })

  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    border = "rounded",
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = wilder.lua_fzy_highlighter(),
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
        icons = { ["+"] = "", a = "", h = "" },
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  }))
  local wildmenu_renderer = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
    apply_incsearch_fix = true,
  })
  wilder.set_option(
    "renderer",
    wilder.renderer_mux({
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    })
  )
end

function config.filetype()
  -- In init.lua or filetype.nvim's config file
  require("filetype").setup({
    overrides = {
      shebang = {
        -- Set the filetype of files with a dash shebang to sh
        dash = "sh",
      },
    },
  })
end

return config
