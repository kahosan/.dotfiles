local config = {}

function config.alpha()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
    [[██╗  ██╗ █████╗ ██╗  ██╗ ██████╗ ███████╗ █████╗ ███╗   ██╗]],
    [[██║ ██╔╝██╔══██╗██║  ██║██╔═══██╗██╔════╝██╔══██╗████╗  ██║]],
    [[█████╔╝ ███████║███████║██║   ██║███████╗███████║██╔██╗ ██║]],
    [[██╔═██╗ ██╔══██║██╔══██║██║   ██║╚════██║██╔══██║██║╚██╗██║]],
    [[██║  ██╗██║  ██║██║  ██║╚██████╔╝███████║██║  ██║██║ ╚████║]],
    [[╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝]],
  }

  local function button(sc, txt, leader_txt, keybind, keybind_opts)
    local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<leader>")

    local opts = {
      position = "center",
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl_shortcut = "Keyword",
    }

    if nil == keybind then
      keybind = sc_after
    end
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_after, keybind, keybind_opts }

    local function on_press()
      -- local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
      local key = vim.api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
      type = "button",
      val = txt,
      on_press = on_press,
      opts = opts,
    }
  end

  local leader = "comma"
  dashboard.section.buttons.val = {
    button("comma f r", " File frecency", leader, "<cmd>Telescope frecency<cr>"),
    button("comma f e", " File history", leader, "<cmd>Telescope oldfiles<cr>"),
    button("comma f p", " Project find", leader, "<cmd>Telescope project<cr>"),
    button("comma f f", " File find", leader, "<cmd>Telescope find_files<cr>"),
    button("comma f n", " File new", leader, "<cmd>enew<cr>"),
    button("comma f w", " Word find", leader, "<cmd>Telescope live_grep<cr>"),
  }
  dashboard.section.buttons.opts.hl = "String"

  local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    return "   Have Fun with neovim"
      .. "   v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "   "
      .. total_plugins
      .. " plugins"
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "Function"

  local head_butt_padding = 2
  local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
  local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
  local foot_butt_padding = 1

  dashboard.config.layout = {
    { type = "padding", val = header_padding },
    dashboard.section.header,
    { type = "padding", val = head_butt_padding },
    dashboard.section.buttons,
    { type = "padding", val = foot_butt_padding },
    dashboard.section.footer,
  }

  alpha.setup(dashboard.opts)
end

function config.catppuccin()
  vim.g.catppuccin_flavour = "mocha"

  local cp = require("catppuccin.palettes").get_palette() -- Get the palette.
  require("catppuccin").setup({
    dim_inactive = {
      enabled = false, -- Dim the inactive splits/windows/buffers displayed.
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = true,
    term_colors = true,
    compile = {
      enabled = true, -- Experimental Feat, testing...
      path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    styles = {
      comments = { "italic" },
      properties = { "italic" },
      functions = { "italic", "bold" },
      keywords = { "italic" },
      operators = { "bold" },
      conditionals = { "bold" },
      loops = { "bold" },
      booleans = { "bold", "italic" },
      numbers = {},
      types = {},
      strings = {},
      variables = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      lsp_trouble = true,
      lsp_saga = true,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = { enabled = true, show_root = true },
      which_key = false,
      indent_blankline = { enabled = true, colored_indent_levels = false },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = false,
      cmp = true,
      notify = true,
      symbols_outline = true,
      coc_nvim = false,
      leap = false,
      neotree = { enabled = false, show_root = true, transparent_panel = false },
      telekasten = true,
      mini = false,
      aerial = false,
      vimwiki = true,
      beacon = false,
    },
    color_overrides = {
      mocha = {
        rosewater = "#F5E0DC",
        flamingo = "#F2CDCD",
        mauve = "#DDB6F2",
        pink = "#F5C2E7",
        red = "#F28FAD",
        maroon = "#E8A2AF",
        peach = "#F8BD96",
        yellow = "#FAE3B0",
        green = "#ABE9B3",
        blue = "#96CDFB",
        sky = "#89DCEB",
        teal = "#B5E8E0",
        lavender = "#C9CBFF",

        text = "#D9E0EE",
        overlay2 = "#C3BAC6",
        overlay1 = "#988BA2",
        overlay0 = "#6E6C7E",
        surface2 = "#575268",
        surface0 = "#302D41",
        mantle = "#1A1826",
        crust = "#161320",
      },
    },
    custom_highlights = {
      -- For base configs.
      Comment = { fg = cp.overlay1 },
      LineNr = { fg = cp.overlay1 },
      CursorLineNr = { fg = cp.green },

      -- For native lsp configs.
      DiagnosticVirtualTextError = { bg = "NONE" },
      DiagnosticVirtualTextWarn = { bg = "NONE" },
      DiagnosticVirtualTextInfo = { bg = "NONE" },
      DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = "NONE" },

      DiagnosticHint = { fg = cp.rosewater },
      DiagnosticUnderlineInfo = { sp = cp.rosewater },
      LspDiagnosticsDefaultHint = { fg = cp.rosewater },
      LspDiagnosticsHint = { fg = cp.rosewater },
      LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
      LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

      -- For treesitter.
      TSField = { fg = cp.rosewater },
      TSProperty = { fg = cp.yellow },

      TSInclude = { fg = cp.teal },
      TSOperator = { fg = cp.sky },
      TSKeywordOperator = { fg = cp.mauve },
      TSPunctSpecial = { fg = cp.maroon },

      TSConstructor = { fg = cp.lavender },
      TSException = { fg = cp.peach },

      TSConstBuiltin = { fg = cp.lavender },
      TSVariableBuiltin = { fg = cp.red, style = { "italic" } },

      TSFuncMacro = { fg = cp.red, style = {} },
      TSParameter = { fg = cp.rosewater },
      TSKeywordFunction = { fg = cp.maroon },
      TSKeywordReturn = { fg = cp.pink, style = {} },

      TSMethod = { style = { "italic" } },
      TSNamespace = { fg = cp.rosewater },

      TSPunctDelimiter = { fg = cp.teal },
      TSPunctBracket = { fg = cp.overlay2 },

      TSType = { fg = cp.yellow },
      TSVariable = { fg = cp.text },
      TSTagAttribute = { fg = cp.mauve },
      TSTag = { fg = cp.peach },
      TSTagDelimiter = { fg = cp.maroon },
      TSText = { fg = cp.text },

      bashTSFuncBuiltin = { fg = cp.red, style = { "italic" } },
      bashTSParameter = { fg = cp.yellow, style = { "italic" } },

      luaTSField = { fg = cp.lavender },
      luaTSConstructor = { fg = cp.flamingo },

      javaTSConstant = { fg = cp.teal },

      typescriptTSProperty = { fg = cp.lavender, style = { "italic" } },

      cssTSType = { fg = cp.lavender },
      cssTSProperty = { fg = cp.yellow, style = { "italic" } },

      cppTSProperty = { fg = cp.text },
    },
  })
end

function config.lualine()
  local gps = require("nvim-gps")

  local function gps_content()
    if gps.is_available() then
      return gps.get_location()
    else
      return ""
    end
  end

  local function escape_status()
    local ok, m = pcall(require, "better_escape")
    return ok and m.waiting and "✺ " or ""
  end

  local mini_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  }
  -- local simple_sections = {
  --   lualine_a = { "mode" },
  --   lualine_b = { "filetype" },
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { "location" },
  -- }
  local aerial = {
    sections = mini_sections,
    filetypes = { "aerial" },
  }

  local function python_venv()
    local function env_cleanup(venv)
      if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch("([^/]+)") do
          final_venv = w
        end
        venv = final_venv
      end
      return venv
    end

    if vim.bo.filetype == "python" then
      local venv = os.getenv("CONDA_DEFAULT_ENV")
      if venv then
        return string.format("%s", env_cleanup(venv))
      end
      venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return string.format("%s", env_cleanup(venv))
      end
    end
    return ""
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      disabled_filetypes = {},
      component_separators = "|",
      -- section_separators = { left = "", right = "" },
      section_separators = { left = " ", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch" }, { "diff" } },
      lualine_c = {
        -- { "lsp_progress" },
        { gps_content, cond = gps.is_available },
      },
      lualine_x = {
        { escape_status },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " " },
        },
      },
      lualine_y = {
        { "filetype", colored = true, icon_only = true },
        { python_venv },
        { "encoding" },
        {
          "fileformat",
          icons_enabled = true,
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
      },
      lualine_z = { "progress", "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      "nvim-tree",
      "toggleterm",
      aerial,
    },
  })
end

function config.nvim_gps()
  require("nvim-gps").setup({
    icons = {
      ["class-name"] = " ", -- Classes and class-like objects
      ["function-name"] = " ", -- Functions
      ["method-name"] = " ", -- Methods (functions inside class-like objects)
    },
    languages = {
      -- You can disable any language individually here
      ["c"] = true,
      ["cpp"] = true,
      ["go"] = true,
      ["java"] = true,
      ["javascript"] = true,
      ["lua"] = true,
      ["python"] = true,
      ["rust"] = true,
    },
    separator = " > ",
  })
end

function config.nvim_tree()
  require("nvim-tree").setup({
    respect_buf_cwd = true,
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = "name",
    update_cwd = true,
    view = {
      width = 30,
      height = 30,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      hide_root_folder = false,
    },
    renderer = {
      root_folder_modifier = ":e",
      icons = {
        padding = " ",
        symlink_arrow = "  ",
        glyphs = {
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "➜",
            untracked = "",
            deleted = "",
            ignored = "◌",
          },
          -- ["default"] = "", --
          -- ["symlink"] = "",
          -- ["git"] = {
          --   ["unstaged"] = "",
          --   ["staged"] = "", --
          --   ["unmerged"] = "שׂ",
          --   ["renamed"] = "", --
          --   ["untracked"] = "ﲉ",
          --   ["deleted"] = "",
          --   ["ignored"] = "", --◌
          -- },
          -- ["folder"] = {
          --   -- ['arrow_open'] = "",
          --   -- ['arrow_closed'] = "",
          --   ["arrow_open"] = "",
          --   ["arrow_closed"] = "",
          --   ["default"] = "",
          --   ["open"] = "",
          --   ["empty"] = "",
          --   ["empty_open"] = "",
          --   ["symlink"] = "",
          --   ["symlink_open"] = "",
          -- },
        },
      },
      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    ignore_ft_on_setup = {},
    filters = {
      dotfiles = false,
      custom = { ".DS_Store" },
      exclude = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
  })
end

function config.nvim_bufferline()
  require("bufferline").setup({
    options = {
      -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
      close_command = "Bdelete! %d",
      right_mouse_command = "Bdelete! %d",
      -- 使用 nvim 内置lsp
      diagnostics = "nvim_lsp",
      -- 左侧让出 nvim-tree 的位置
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "right",
        },
      },
      diagnostic_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
    },
  })
end

function config.gitsigns()
  require("gitsigns").setup({
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = "│",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = "│",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "_",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "‾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
      ["n ]g"] = {
        expr = true,
        "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
      },
      ["n [g"] = {
        expr = true,
        "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
      },
      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame = true,
    current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    word_diff = false,
    diff_opts = { internal = true },
  })
end

function config.indent_blankline()
  require("indent_blankline").setup({
    char = "│",
    show_first_indent_level = true,
    filetype_exclude = {
      "startify",
      "dashboard",
      "dotooagenda",
      "log",
      "fugitive",
      "gitcommit",
      "packer",
      "vimwiki",
      "markdown",
      "json",
      "txt",
      "vista",
      "help",
      "todoist",
      "NvimTree",
      "peekaboo",
      "git",
      "TelescopePrompt",
      "undotree",
      "flutterToolsOutline",
      "", -- for all buffers without a file type
    },
    buftype_exclude = { "terminal", "nofile" },
    show_trailing_blankline_indent = false,
    show_current_context = false,
    context_patterns = {
      "class",
      "function",
      "method",
      "block",
      "list_literal",
      "selector",
      "^if",
      "^table",
      "if_statement",
      "while",
      "for",
      "type",
      "var",
      "import",
    },
    space_char_blankline = " ",
  })
  -- because lazy load indent-blankline so need readd this autocmd
  vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

return config
