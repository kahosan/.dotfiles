return vim.schedule_wrap(function()
  local use_ssh = require("core.settings").use_ssh
  local treesitter_deps = require("core.settings").treesitter_deps

  require("nvim-treesitter.configs").setup({
    ensure_installed = treesitter_deps,
    highlight = {
      enable = true,
      disable = function(ft, bufnr)
        if vim.tbl_contains({ "gitcommit" }, ft) or (vim.api.nvim_buf_line_count(bufnr) > 7500 and ft ~= "vimdoc") then
          return true
        end

        local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
        return ok and is_large_file
      end,
      additional_vim_regex_highlighting = { "c", "cpp" },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]["] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
    },
    indent = { enable = true },
    matchup = { enable = true },
  })
  require("nvim-treesitter.install").prefer_git = true
  if use_ssh then
    local parsers = require("nvim-treesitter.parsers").get_parser_configs()
    for _, p in pairs(parsers) do
      p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
    end
  end
end)
