return function()
  local icons = { ui = require("modules.utils.icons").get("ui", true) }
  local lga_actions = require("telescope-live-grep-args.actions")
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")
  local TSLayout = require("telescope.pickers.layout")

  local function make_popup(options)
    local popup = Popup(options)
    function popup.border:change_title(title)
      popup.border.set_text(popup.border, "top", title)
    end
    return TSLayout.Window(popup)
  end

  local create_layout = function(picker)
    local border = {
      results = {
        top_left = "┌",
        top = "─",
        top_right = "┬",
        right = "│",
        bottom_right = "",
        bottom = "",
        bottom_left = "",
        left = "│",
      },
      results_patch = {
        minimal = {
          top_left = "┌",
          top_right = "┐",
        },
        horizontal = {
          top_left = "┌",
          top_right = "┬",
        },
        vertical = {
          top_left = "├",
          top_right = "┤",
        },
      },
      prompt = {
        top_left = "├",
        top = "─",
        top_right = "┤",
        right = "│",
        bottom_right = "┘",
        bottom = "─",
        bottom_left = "└",
        left = "│",
      },
      prompt_patch = {
        minimal = {
          bottom_right = "┘",
        },
        horizontal = {
          bottom_right = "┴",
        },
        vertical = {
          bottom_right = "┘",
        },
      },
      preview = {
        top_left = "┌",
        top = "─",
        top_right = "┐",
        right = "│",
        bottom_right = "┘",
        bottom = "─",
        bottom_left = "└",
        left = "│",
      },
      preview_patch = {
        minimal = {},
        horizontal = {
          bottom = "─",
          bottom_left = "",
          bottom_right = "┘",
          left = "",
          top_left = "",
        },
        vertical = {
          bottom = "",
          bottom_left = "",
          bottom_right = "",
          left = "│",
          top_left = "┌",
        },
      },
    }
    local results = make_popup({
      focusable = false,
      border = {
        style = border.results,
        text = {
          top = picker.results_title,
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal",
      },
    })

    local prompt = make_popup({
      enter = true,
      border = {
        style = border.prompt,
        text = {
          top = picker.prompt_title,
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal",
      },
    })

    local preview = make_popup({
      focusable = false,
      border = {
        style = border.preview,
        text = {
          top = picker.preview_title,
          top_align = "center",
        },
      },
    })

    local box_by_kind = {
      vertical = Layout.Box({
        Layout.Box(preview, { grow = 1 }),
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col" }),
      horizontal = Layout.Box({
        Layout.Box({
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col", size = "50%" }),
        Layout.Box(preview, { size = "50%" }),
      }, { dir = "row" }),
      minimal = Layout.Box({
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col" }),
    }

    local function get_box()
      local strategy = picker.layout_strategy
      if strategy == "vertical" or strategy == "horizontal" then
        return box_by_kind[strategy], strategy
      end

      local height, width = vim.o.lines, vim.o.columns
      local box_kind = "horizontal"
      if width < 100 then
        box_kind = "vertical"
        if height < 40 then
          box_kind = "minimal"
        end
      end
      return box_by_kind[box_kind], box_kind
    end

    local function prepare_layout_parts(layout, box_type)
      layout.results = results
      results.border:set_style(border.results_patch[box_type])

      layout.prompt = prompt
      prompt.border:set_style(border.prompt_patch[box_type])

      if box_type == "minimal" then
        layout.preview = nil
      else
        layout.preview = preview
        preview.border:set_style(border.preview_patch[box_type])
      end
    end

    local function get_layout_size(box_kind)
      return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
    end

    local box, box_kind = get_box()
    local layout = Layout({
      relative = "editor",
      position = "50%",
      size = get_layout_size(box_kind),
    }, box)

    layout.picker = picker
    prepare_layout_parts(layout, box_kind)

    local layout_update = layout.update
    function layout:update()
      local box, box_kind = get_box()
      prepare_layout_parts(layout, box_kind)
      layout_update(self, { size = get_layout_size(box_kind) }, box)
    end

    return TSLayout(layout)
  end

  require("telescope").setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
      initial_mode = "insert",
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.ChevronRight,
      scroll_strategy = "limit",
      results_title = false,
      path_display = { "absolute" },
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      color_devicons = true,
      file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          size = {
            width = "90%",
            height = "80%",
          },
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          size = {
            width = "90%",
            height = "90%",
          },
          mirror = false,
        },
        width = 0.85,
        height = 0.92,
        preview_cutoff = 120,
      },
      create_layout = create_layout,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
      undo = {
        side_by_side = true,
        mappings = { -- this whole table is the default
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to use the following actions. This means installing as a dependency of
            -- telescope in it's `requirements` and loading this extension from there instead of
            -- having the separate plugin definition as outlined above. See issue #6.
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
    },
  })

  require("telescope").load_extension("frecency")
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("live_grep_args")
  require("telescope").load_extension("projects")
  require("telescope").load_extension("undo")
  require("telescope").load_extension("zoxide")
end
