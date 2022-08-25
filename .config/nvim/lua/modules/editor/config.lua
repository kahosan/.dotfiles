local config = {}


function config.illuminate()
  -- Use background for "Visual" as highlight for words. Change this behavior here!
	if vim.api.nvim_get_hl_by_name("Visual", true).background then
		local illuminate_bg = string.format("#%06x", vim.api.nvim_get_hl_by_name("Visual", true).background)

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = illuminate_bg })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = illuminate_bg })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = illuminate_bg })
	end

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
  -- vim.api.nvim_command("set foldmethod=expr")
  vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

  require("nvim-treesitter.configs").setup({
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
    highlight = { enable = true, disable = { "vim" } },
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

function config.tabout()
  require("tabout").setup({
    tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
    default_shift_tab = "<C-d>", -- reverse shift default action,
    enable_backwards = true, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  })
end

return config
