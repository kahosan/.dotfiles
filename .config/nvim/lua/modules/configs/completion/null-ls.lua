return function()
  local null_ls = require("null-ls")
  local btns = null_ls.builtins

  ---Return formatter args required by `extra_args`
  ---@param formatter_name string
  ---@return table|nil
  local function formatter_args(formatter_name)
    local args = require("completion.formatters." .. formatter_name)
    return args
  end

  -- Please set additional flags for the supported servers here
  -- Don't specify any config here if you are using the default one.
  local sources = {
    btns.formatting.clang_format.with({
      filetypes = { "c", "cpp", "objc", "objcpp", "cs", "cuda", "proto" },
      extra_args = formatter_args("clang_format"),
    }),
    btns.formatting.prettier.with({
      filetypes = {
        "yaml",
        "css",
        "scss",
        "sh",
      },
    }),
  }
  require("null-ls").setup({
    border = "single",
    debug = false,
    log_level = "warn",
    update_in_insert = false,
    sources = sources,
    default_timeout = require("core.settings").format_timeout,
  })

  require("completion.mason-null-ls").setup()

  -- Setup usercmd to register/deregister available source(s)
  local function _gen_completion()
    local sources_cont = null_ls.get_source({
      filetype = vim.bo.filetype,
    })
    local completion_items = {}
    for _, server in pairs(sources_cont) do
      table.insert(completion_items, server.name)
    end
    return completion_items
  end
  vim.api.nvim_create_user_command("NullLsToggle", function(opts)
    if vim.tbl_contains(_gen_completion(), opts.args) then
      null_ls.toggle({ name = opts.args })
    else
      vim.notify(
        string.format("[Null-ls] Unable to find any registered source named [%s].", opts.args),
        vim.log.levels.ERROR,
        { title = "Null-ls Internal Error" }
      )
    end
  end, {
    nargs = 1,
    complete = _gen_completion,
  })
end
