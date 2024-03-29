return function()
  local null_ls = require("null-ls")
  local mason_null_ls = require("mason-null-ls")
  local btns = null_ls.builtins

  local sources = {
    btns.formatting.black.with({
      extra_args = { "--fast", "--line-length", "100" },
    }),
    btns.formatting.clang_format.with({
      filetypes = { "c", "cpp" },
      extra_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" },
    }),
    btns.formatting.prettier.with({
      filetypes = {
        "yaml",
        "css",
        "scss",
        "sh",
        "markdown",
      },
    }),
    btns.formatting.rustfmt,
  }

  null_ls.setup({
    border = "single",
    debug = false,
    log_level = "warn",
    update_in_insert = false,
    diagnostics_format = "#{m} (#{s})",
    sources = sources,
  })

  mason_null_ls.setup({
    ensure_installed = require("core.settings").null_ls_deps,
    automatic_installation = false,
    automatic_setup = true,
    handlers = {},
  })

  local function _gen_completion()
    local sources_cont = null_ls.get_source({
      filetype = vim.api.nvim_get_option_value("filetype", { scope = "local" }),
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

  require("completion.formatting").configure_format_on_save()
end
