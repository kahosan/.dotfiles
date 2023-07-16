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

  require("completion.formatting").configure_format_on_save()
end
