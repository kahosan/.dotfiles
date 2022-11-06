local config = {}

function config.illuminate()
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "alpha",
      "dashboard",
      "DoomInfo",
      "fugitive",
      "help",
      "norg",
      "NvimTree",
      "Outline",
      "packer",
      "toggleterm",
    },
    under_cursor = false,
  })
end

function config.nvim_treesitter()
  vim.api.nvim_set_option_value("foldmethod", "expr", {})
  -- vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

  require("nvim-treesitter.configs").setup({
    autotag = {
      enable = true,
    },
    ensure_installed = {
      "bash",
      "lua",
      "go",
      "gomod",
      "json",
      "yaml",
      "python",
      "rust",
      "html",
      "tsx",
      "vue",
      "css",
    },
    highlight = {
      enable = true,
      disable = { "vim" },
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = { "python", "go", "rust", "c", "cpp" },
    },
  })
  require("nvim-treesitter.install").prefer_git = true
  local parsers = require("nvim-treesitter.parsers").get_parser_configs()
  parsers.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  for _, p in pairs(parsers) do
    p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
  end
end

function config.nvim_colorizer()
  require("colorizer").setup()
end

function config.better_escape()
  require("better_escape").setup({
    mapping = { "jk" }, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    -- example(recommended)
    -- keys = function()
    --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    -- end,
  })
end

function config.autotag()
  require("nvim-ts-autotag").setup({
    filetypes = {
      "html",
      "xml",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "vue",
    },
  })
end

function config.toggleterm()
  require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.40
      end
    end,
    on_open = function()
      -- Prevent infinite calls from freezing neovim.
      -- Only set these options specific to this terminal buffer.
      vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
      vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
  })
end

return config
