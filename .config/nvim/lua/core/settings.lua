local settings = {}

-- Set it to false if you want to use https to update plugins and treesitter parsers.
---@type boolean
settings["use_ssh"] = false

-- NOTE: The startup time will be slowed down when it's true.
-- Set it to false if you don't use nvim to open big files.
---@type boolean
settings["load_big_files_faster"] = true

-- Change the colors of the global palette here.
-- Settings will complete their replacement at initialization.
-- Parameters will be automatically completed as you type.
-- Example: { sky = "#04A5E5" }
---@type table<string, string>
settings["palette_overwrite"] = {}

-- Set the colorscheme to use here.
-- settings["colorscheme"] = "alabaster"
settings["colorscheme"] = "catppuccin"
-- settings["colorscheme"] = "default"

-- Set background color to use here.
-- Useful if you would like to use a colorscheme that has a light and dark variant like `edge`.
-- Valid values are: `dark`, `light`.
---@type "dark"|"light"
settings["background"] = "dark"

-- Set the command for handling external URLs here. The executable must be available on your $PATH.
-- This entry is IGNORED on Windows and macOS, which have their default handlers builtin.
---@type string
settings["external_browser"] = "chrome-cli open"

-- Set the transparent the background here.
settings["transparent_background"] = false

-- Set the language servers that will be installed during bootstrap here.
-- check the below link for all the supported LSPs:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---@type string[]
settings["lsp_deps"] = {
  "bashls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "eslint",
  -- "rust_analyzer"
  -- "ts_ls",
}

-- Set the plugins to disable here.
-- Example: "Some-User/A-Repo"
---@type string[]
settings["disabled_plugins"] = {}

-- Set the Treesitter parsers that will be installed during bootstrap here.
-- Check the below link for all supported languages:
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
---@type string[]
settings["treesitter_deps"] = {
  "bash",
  "c",
  "cpp",
  "css",
  "go",
  "gomod",
  "html",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "typescript",
  "tsx",
  "vimdoc",
  "vue",
  "yaml",
  "toml",
}

return settings
